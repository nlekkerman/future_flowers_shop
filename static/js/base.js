/* jshint esversion: 8 */
import {
    getCartFromLocalStorage
} from './utils.js';
import {
    sendToCart
} from './control.js';

/* 
* Retrieves all seed data from localStorage.
* This function fetches the seed data stored in localStorage and returns it as an array.
* If no seed data is found, an empty array is returned.
*
* Returns:
*   Array: The array of seed data, or an empty array if no data is found.
*/
function getAllSeeds() {
    return JSON.parse(localStorage.getItem('seeds_data')) || [];
}

/* 
* Retrieves a specific seed from localStorage based on the given seed ID.
* This function finds the seed matching the provided seed ID from the list of all seeds.
* It returns the seed object if found, or undefined if the seed is not found.
*
* Parameters:
*   - seedId (string): The ID of the seed to be retrieved from localStorage.
*
* Returns:
*   Object: The seed object if found, otherwise undefined.
*/
function getSeedFromLocalStorage(seedId) {
    const seeds = getAllSeeds();
    return seeds.find(seed => seed.id === parseInt(seedId, 10));
}

/* 
* Searches for seeds based on the given query, category, and sun preference.
* This function filters the list of seeds to find those that match the search criteria.
* It updates the UI to display the search results.
*
* Parameters:
*   - query (string): The search query to look for in seed names or descriptions.
*   - category (string, optional): The category to filter seeds by.
*   - sunPreference (string, optional): The sun preference to filter seeds by.
*/
export function searchSeeds(query, category = '', sunPreference = '') {
    const seedsData = getAllSeeds();
    const lowerCaseQuery = query.toLowerCase(); // Convert query to lowercase once for better performance

    const results = seedsData.filter(seed => {
        const matchesQuery =
            seed.name.toLowerCase().includes(lowerCaseQuery) ||
            seed.scientific_name.toLowerCase().includes(lowerCaseQuery) ||
            (seed.description && seed.description.toLowerCase().includes(lowerCaseQuery));

        const matchesCategory = !category || seed.category.toLowerCase() === category.toLowerCase();
        const matchesSunPreference = !sunPreference || seed.sun_preference.toLowerCase() === sunPreference.toLowerCase();

        return matchesQuery && matchesCategory && matchesSunPreference;
    });

    displaySearchResults(results);
    toggleSearchResults();
}

/* 
* Adds a seed item to the cart with a specified quantity.
* This function checks if the seed is already in the cart, and if it is, it updates the quantity and total price.
* If the seed is not in the cart, it adds the item as a new entry.
* The cart data is then saved to localStorage.
*
* Parameters:
*   - seed (Object): The seed object to be added to the cart.
*   - quantity (number, optional): The quantity of the seed to be added to the cart (defaults to 1).
*/
function addToCart(seed, quantity = 1) {
    let cartData = getCartFromLocalStorage(); // Fetch current cart data

    // Use the full URL directly if available, otherwise use a fallback image URL
    let imageUrl = seed.image || '/media/images/wild-flowers-icon.webp';

    // Calculate the correct price: either discounted or original price
    let itemPrice = seed.discount > 0 ? parseFloat(seed.discounted_price) : parseFloat(seed.price);
    // Find if the item already exists in the cart
    const existingItemIndex = cartData.items.findIndex(item => item.seed.id === seed.id);

    if (existingItemIndex >= 0) {
        // Item is already in cart, update the quantity and total price
        cartData.items[existingItemIndex].quantity += quantity;
        cartData.items[existingItemIndex].total_price = cartData.items[existingItemIndex].quantity * itemPrice;
    } else {
        // New item, add to cart
        cartData.items.push({
            id: Date.now(), // Unique ID for the cart item
            seed: {
                id: seed.id,
                name: seed.name,
                price: itemPrice, // Use the correct price
                image: imageUrl,
                is_in_stock: seed.is_in_stock // Add stock status
            },
            quantity: quantity,
            total_price: itemPrice * quantity
        });
    }

    // Calculate total cart price
    const total_price = cartData.items.reduce((total, item) => total + item.total_price, 0);

    // Prepare updated cart data
    const updatedCartData = {
        id: cartData.id || Date.now(), // Generate a new cart ID if it doesn't exist
        user: 'current_user', // Placeholder for user information
        created_at: cartData.created_at || new Date().toISOString(),
        updated_at: new Date().toISOString(),
        total_price: total_price.toFixed(2),
        items: cartData.items
    };

    // Save updated cart data to localStorage
    localStorage.setItem('cart', JSON.stringify(updatedCartData));

    // Optionally, show a success message
    displayMessageInModal('Item successfully added to your cart!', {
        image: imageUrl,
        quantity
    });


}

/* 
* Updates the cart UI with the latest item count and total price.
* This function fetches the updated cart data from localStorage and updates the cart count and total price
* on the webpage accordingly.
*/
function updateCartUI() {
    const cartData = getCartFromLocalStorage(); // Fetch the updated cart data
    const cartCountElement = document.getElementById('cart-count'); // Element for item count
    const cartTotalElement = document.getElementById('cart-total'); // Element for total price

    // Validate cart data
    if (!cartData || !cartData.items) {
        console.warn('No cart data found or cart items are missing.');
        return;
    }

    // Update item count in the UI
    const itemCount = cartData.items.reduce((total, item) => total + item.quantity, 0);
    if (cartCountElement) {
        cartCountElement.textContent = itemCount; // Display the total number of items
    }

    // Update total price in the UI
    const totalPrice = parseFloat(cartData.total_price) || 0;
    if (cartTotalElement) {
        cartTotalElement.textContent = `$${totalPrice.toFixed(2)}`; // Display the total price
    }

}

/* 
* Displays a message in a modal to inform the user that an item has been successfully added to the cart.
* The modal is displayed with a background image and information about the item added to the cart.
*
* Parameters:
*   - message (string): The message to be displayed in the modal.
*   - item (Object): The item details such as quantity and image to be shown in the modal.
*/
export function displayMessageInModal(message, item) {
    const messagesContainer = document.getElementById('item-added-search-message');



    // Fetch image URL based on item ID
    const imageUrl = `https://res.cloudinary.com/dg0ssec7u/image/upload/${item.image}.webp`;

    // Update background image and styles
    messagesContainer.style.backgroundImage = `url('${imageUrl}')`;
    messagesContainer.style.backgroundSize = 'cover'; 
    messagesContainer.style.backgroundPosition = 'center'; 
    messagesContainer.style.backgroundRepeat = 'no-repeat';
    messagesContainer.style.backgroundColor = 'rgba(0, 0, 0, 0.9)'; 
    // Set the message content
    messagesContainer.innerHTML = `
        <div class="message-content">
            <p class="message-added">${message}</p>
            <p><strong>Quantity in Cart:</strong> ${item.quantity}</p>
            <button class="btn-close-message btn" onclick="hideItemAddedMessage()">Close</button>
        </div>
    `;

    // Display the message container
    messagesContainer.style.display = 'block';
    setTimeout(() => {
        messagesContainer.style.display = 'none';
        console.log('Message container hidden.');
    }, 5000); 
}

/* 
* Hides the item added message modal when the close button is clicked.
* This function removes the message modal from the screen after it has been displayed.
*/
export function hideItemAddedMessage() {
    const messagesContainer = document.getElementById('item-added-search-message');
    if (messagesContainer) {
        messagesContainer.style.display = 'none';
    }
}

/* 
* Toggles the visibility of the search details modal.
* This function shows or hides the search seed details modal based on its current state.
*/
function showSearchDetailsModal() {
    const modal = document.getElementById('search-seed-details-modal');
    if (modal) {
        modal.style.display = 'block';
    }
}

/* 
* Toggles the visibility of the search results container.
* This function either shows or hides the search results and updates the search button text accordingly.
*/
let isSearchResultsVisible = false;

/* 
* Toggles the visibility of search results and search container.
* Updates button text and adjusts the display of related elements.
*/
function toggleSearchResults() {
    const resultsContainer = document.getElementById('search-results-container');
    const searchButton = document.getElementById('search-button');
    const searchIcon = document.getElementById('searchIcon');
    const searchContainer = document.getElementById('searchContainer');

    if (resultsContainer) {
        if (isSearchResultsVisible) {
            // Hide the results container
            resultsContainer.style.opacity = '0';
            resultsContainer.style.visibility = 'hidden';
            searchButton.innerHTML = '<i class="fas fa-search"></i>';
            isSearchResultsVisible = false;

            // Hide search container when close button is clicked
            searchContainer.classList.remove('focused');
            searchContainer.classList.remove('show');
            searchIcon.style.opacity = '1'; // Show the icon again
        } else {
            // Show the results container
            resultsContainer.style.opacity = '1';
            resultsContainer.style.visibility = 'visible';
            searchButton.textContent = 'Close'; // Update button text
            searchContainer.classList.add('focused');
            isSearchResultsVisible = true;
        }
    }
}

/* 
* Displays search results for the seeds in the results container.
* Handles seed data presentation and formatting.
*/
function displaySearchResults(seeds) {
    const seedsContainer = document.getElementById('search-results-container');


    seedsContainer.innerHTML = '';

    if (seeds.length === 0) {
        seedsContainer.innerHTML = '<p>No results found.</p>';
        return;
    }

    seeds.forEach(seed => {
        const searchSeedElement = document.createElement('div');
        searchSeedElement.className = 'search-card mb-4';

        let seedHTML = `
        <div class="seed-card h-100" id="seed-card-${seed.id}" data-seed-id="${seed.id}">
            <div class="card-img-container">
                <img src="${seed.image ? `https://res.cloudinary.com/dg0ssec7u/image/upload/${seed.image}.webp` : '/static/default_image.jpg'}" class="search-item-img" alt="${seed.name}">
                ${seed.discount > 0 ? '<span class="discount-label">Discounted</span>' : ''}
            </div>
            <div class="card-body seed-card-body ">
                <h2 class="card-title card-title-serach h5">${seed.name}</h2>
                <p class="card-text card-text-search"><strong>Scientific Name:</strong> ${seed.scientific_name}</p>
                <p class="card-text card-text-search"><strong>Planting Months:</strong> ${seed.planting_months_from} to ${seed.planting_months_to}</p>
                <p class="card-text card-text-search"><strong>Flowering Months:</strong> ${seed.flowering_months_from} to ${seed.flowering_months_to}</p>
                <p class="card-text card-text-search">
                    <strong>Price:</strong> 
                    ${seed.discount > 0 ? 
                        `<span class="original-price">$${seed.price}</span> <span class="discounted-price">$${seed.discounted_price}</span>` 
                        : `$${seed.price}`}
                </p>
                ${seed.is_in_stock ? 
                    '<p class="card-text text-success"><strong>In Stock</strong></p>' : 
                    '<p class="card-text text-danger"><strong>Out of Stock</strong></p>'}
            </div>
            <div class="card-footer text-center">
                <button class="btn add-to-cart-button ${!seed.is_in_stock ? 'out-of-stock' : ''}" data-seed-id="${seed.id}" ${seed.is_in_stock ? '' : 'disabled'}>
                    ${seed.is_in_stock ? 'Add to Cart' : 'Out of Stock'}
                </button>
            </div>
        </div>
        `;

        searchSeedElement.innerHTML = seedHTML;
        seedsContainer.appendChild(searchSeedElement);
        searchSeedElement.addEventListener('click', () => {
            const modal = document.getElementById('search-seed-details-modal');
            // Toggle the modal visibility using a class
            modal.classList.toggle('modal-visible');

        });



    });
    attachSeedCardEventListeners();
    attachAddToCartButtonEventListeners();
}
document.addEventListener("DOMContentLoaded", function() {
    const profileImage = document.getElementById("profile-image");
    const profileImageUrl = profileImage.getAttribute("data-profile-url");

    // Check if the profile image URL is different from the default
    if (profileImageUrl && profileImageUrl !== profileImage.src) {
        profileImage.src = profileImageUrl;  // Set profile image URL if it exists
    }
});

/* 
* Attaches event listeners to seed cards for click actions.
* Handles showing seed details in a modal on card click.
*/
function displaySearchResultsSeedDetails(seed) {
    let isSeedDetailsVisible = false;
    const seedDetailsContent = document.getElementById('search-seed-details-content');
    const seedDetailsModal = document.getElementById('search-seed-details-modal');

    if (!seedDetailsContent) {
        console.log('seedDetailsContent element not found!');
        return;
    }

    seedDetailsContent.innerHTML = `
        <div class="seed-details" style="background-image: url('${seed.image ? `https://res.cloudinary.com/dg0ssec7u/image/upload/${seed.image}.webp` : '/static/default_image.jpg'}'); background-size: cover; background-position: center; padding: 20px; color: white; border-radius: 8px;">
             <button class="close-button" id="closeSeedDetails">
        <i class="fas fa-times"></i>
             </button>
        <h1 style="margin-bottom: 15px; font-size: 24px; color: #fff;">${seed.name}</h1>
            <p style="margin: 5px 0; font-size: 16px;"><strong>Scientific Name:</strong> ${seed.scientific_name}</p>
            <p style="margin: 5px 0; font-size: 16px;"><strong>Description:</strong> ${seed.description || 'No description available'}</p>
            <div class="search-details-general-data">
            <p style="margin: 5px 0; font-size: 16px;"><strong>Planting:</strong> ${seed.planting_months_from} to ${seed.planting_months_to}</p>
            <p style="margin: 5px 0; font-size: 16px;"><strong>Flowering:</strong> ${seed.flowering_months_from} to ${seed.flowering_months_to}</p>
            <p style="margin: 5px 0; font-size: 16px;"><strong>Sun:</strong> ${seed.sun_preference || 'Not specified'}</p>
            <p style="margin: 5px 0; font-size: 16px;"><strong>Price:</strong> $${seed.price}</p>
            ${seed.discount > 0 ? `
                <p style="margin: 5px 0; font-size: 16px;"><strong>Discount:</strong> ${seed.discount}%</p>
                <p style="margin: 5px 0; font-size: 16px;"><strong>Discounted Price:</strong> $${(seed.price - (seed.price * seed.discount / 100)).toFixed(2)}</p>` : ''}
            </div>
            <div style="margin-top: 15px; text-align: center;">
                <button class="btn add-to-cart-button ${!seed.is_in_stock ? 'out-of-stock' : ''}" data-seed-id="${seed.id}" ${!seed.is_in_stock ? 'disabled' : ''}>
                    ${seed.is_in_stock ? 'Add to Cart' : 'Out of Stock'}
                </button>
            </div>
        </div>
    `;

    attachAddToCartButtonEventListeners();


    // Add the event listener for the "Close" button
    const closeButton = document.getElementById('closeSeedDetails');
    if (closeButton) {
        closeButton.addEventListener('click', () => {
            if (seedDetailsModal) {
                seedDetailsModal.style.display = 'none'; 
                isSeedDetailsVisible = false; 
            }
        });
    }

    // Show the seed details modal
    if (seedDetailsModal) {
        seedDetailsModal.style.display = 'block'; 
        isSeedDetailsVisible = true; 
    }
}

/* 
* Attaches event listeners to seed cards for click actions.
* Handles showing seed details in a modal on card click.
*/
function attachSeedCardEventListeners() {
    document.querySelectorAll('.search-seed-card').forEach(card => {
        card.addEventListener('click', (event) => {
            const seedId = card.getAttribute('data-seed-id');
            const seed = getSeedFromLocalStorage(seedId);

            if (seed) {
                displaySearchResultsSeedDetails(seed);
                showSearchDetailsModal();
            } else {
                alert('Oops! We couldn\'t find the seed details. Please try again later.');
            }
        });
    });
}

/* 
* Attaches event listeners to "Add to Cart" buttons for adding items to the cart.
* Ensures cart UI is updated after adding an item.
*/
function attachAddToCartButtonEventListeners() {
    // Attach click event listener to "Add to Cart" buttons
    document.querySelectorAll('.add-to-cart-button').forEach(button => {
        button.addEventListener('click', async (event) => {
            event.stopPropagation(); // Prevent triggering the card click event

            const seedId = button.getAttribute('data-seed-id');
            const quantity = 1; // Default quantity

            // Instead of getting seedElement, directly get the seed details from local storage
            const seed = getSeedFromLocalStorage(seedId);
            const imageUrl = seed.image ? `https://res.cloudinary.com/dg0ssec7u/image/upload/${seed.image}.webp` : '/static/default_image.jpg';

            if (seed) {
               
                addToCart(seed, quantity, imageUrl);
                updateCartUI(); // Ensure the cart UI is updated after adding the item
                try {
                    await sendToCart(seedId, quantity, seed);
                   
                } catch (error) {
                    console.error('Failed to send item to server:', error);
                }

                console.log('After adding to cart:', getCartFromLocalStorage()); // Log cart state after addition
            } else {
                console.error('Seed not found in local storage.', seedId);
            }
        });
    });
}

/* 
* Initializes event listeners and logic for handling search form submission.
* Displays warning if search input is empty and triggers search on valid input.
*/
document.addEventListener('DOMContentLoaded', () => {
    const searchForm = document.getElementById('seed-search-form');
    const searchInput = document.getElementById('seed-search-input');
    const warningMessage = document.getElementById('search-warning');

    if (searchForm) {
        searchForm.addEventListener('submit', (event) => {
            event.preventDefault(); // Prevent the default form submission

            // Get the query input and trim whitespace
            const query = searchInput.value.trim().toLowerCase();

            // Check if the input query is empty
            if (!query) {
                // Display the warning message
                warningMessage.style.display = 'block';
                warningMessage.style.marginTop = '20px';

                // Optionally add a red border around the input to highlight the issue
                searchInput.style.borderColor = 'red';
                // Hide the warning message after 2 seconds
                setTimeout(() => {
                    warningMessage.style.display = 'none';
                    searchInput.style.borderColor = ''; // Reset to default
                }, 2000);

                return; // Exit the function if the query is empty
            }

            // Hide the warning and reset styles if input is valid
            warningMessage.style.display = 'none';
            searchInput.style.borderColor = ''; // Reset to default

            // Scroll to the top smoothly before displaying the search results
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });

            console.log("SEARCH BUTTON CLICKED: ", query);
            searchSeeds(query); // Call your search function with the query
        });
    }
});

/* 
* Hides messages when the "close" button is clicked.
*/
document.addEventListener('click', (event) => {
    if (event.target.classList.contains('btn-close-message')) {
        hideItemAddedMessage();
    }
});

/* 
* Initializes event listeners and logic for closing messages.
* Hides message containers on close button click.
*/
document.addEventListener('DOMContentLoaded', function () {
    // Handle close button clicks
    const closeButtons = document.querySelectorAll('.close-button-container');
    closeButtons.forEach(function (button) {
        button.addEventListener('click', function () {
            const message = this.closest('.message-container');
            if (message) {
                message.style.display = 'none'; 
            }
        });
    });


});

/* 
* Toggles the visibility of the filter container on button click.
* Changes filter icon between filter and close icons.
*/
document.addEventListener('DOMContentLoaded', function () {
    // Get references to the button and filter container
    const toggleButton = document.getElementById('filter-toggle');
    const filterContainer = document.getElementById('filter-container');
    const filterIcon = document.getElementById('filter-icon');

    // Function to toggle the visibility of the filter container
    function toggleFilterVisibility() {
        if (filterContainer.classList.contains('d-none')) {
            filterContainer.classList.remove('d-none'); // Show the filter container
            filterIcon.classList.remove('fa-filter');
            filterIcon.classList.add('fa-times'); // Change icon to a close icon
        } else {
            filterContainer.classList.add('d-none'); // Hide the filter container
            filterIcon.classList.remove('fa-times');
            filterIcon.classList.add('fa-filter'); // Change icon back to filter icon
        }
    }

    // Add event listener to the button
    toggleButton.addEventListener('click', toggleFilterVisibility);
});

/* 
* Initializes event listener for the cart button.
* Redirects to the cart page when clicked.
*/
document.addEventListener('DOMContentLoaded', () => {
    const viewCartButton = document.getElementById('cart-button');

    if (viewCartButton) {
        viewCartButton.addEventListener('click', () => {
            window.location.href = '/cart/'; // Redirect to cart page
        });
       
    }
});
