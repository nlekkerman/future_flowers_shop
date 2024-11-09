import {
    getCartFromLocalStorage
} from './utils.js';
import {
    sendToCart
} from './control.js';
// Function to get all seeds from local storage

function getAllSeeds() {
    return JSON.parse(localStorage.getItem('seeds_data')) || [];
}

// Function to get a seed from local storage
function getSeedFromLocalStorage(seedId) {
    const seeds = getAllSeeds();
    return seeds.find(seed => seed.id === parseInt(seedId, 10));
}

// Function to search seeds
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

// Add item to cart
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


// Update cart UI elements
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

    console.log('Cart UI updated:', {
        itemCount,
        totalPrice
    });
}



// Example displayMessageInModal function
export function displayMessageInModal(message, item) {
    const messagesContainer = document.getElementById('item-added-search-message');

    if (!messagesContainer) {
        console.error('Element with ID "item-added-search-message" not found.');
        return;
    }

    // Log the details for debugging
    console.log('Displaying message in modal:', {
        message,
        item
    });

    // Fetch image URL based on item ID
    const imageUrl = `https://res.cloudinary.com/dg0ssec7u/image/upload/${item.image}.webp`;

    // Update background image and styles
    messagesContainer.style.backgroundImage = `url('${imageUrl}')`;; // Set the background image
    messagesContainer.style.backgroundSize = 'cover'; // Ensure the image covers the container
    messagesContainer.style.backgroundPosition = 'center'; // Center the background image
    messagesContainer.style.backgroundRepeat = 'no-repeat'; // Prevent image repetition
    messagesContainer.style.backgroundColor = 'rgba(0, 0, 0, 0.9)'; // Optional: dark overlay for better readability

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

    // Log message visibility
    console.log('Message container displayed.');

    // Hide the message after a few seconds (optional)
    setTimeout(() => {
        messagesContainer.style.display = 'none';
        console.log('Message container hidden.');
    }, 5000); // Adjust time as needed
}
// Function to hide the message container
export function hideItemAddedMessage() {
    const messagesContainer = document.getElementById('item-added-search-message');
    if (messagesContainer) {
        messagesContainer.style.display = 'none';
    }
}

// Function to show the modal
function showSearchDetailsModal() {
    const modal = document.getElementById('search-seed-details-modal');
    if (modal) {
        modal.style.display = 'block';
    }
}


let isSearchResultsVisible = false;

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
            searchContainer.style.display = 'none'; // Hides the search container
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

function displaySearchResults(seeds) {
    const seedsContainer = document.getElementById('search-results-container');

    if (!seedsContainer) {
        console.error('Element with ID "search-results-container" not found.');
        return;
    }

    seedsContainer.innerHTML = '';

    if (seeds.length === 0) {
        seedsContainer.innerHTML = '<p>No results found.</p>';
        return;
    }

    seeds.forEach(seed => {
        const searchSeedElement = document.createElement('div');
        searchSeedElement.className = 'col-12 col-md-6 col-lg-4 mb-4';

        const backgroundImageUrl = seed.image ? `https://res.cloudinary.com/dg0ssec7u/image/upload/${seed.image}.webp` : '/static/default_image.jpg';

        let seedHTML = `
        <div class="seed-card h-100" id="seed-card-${seed.id}" data-seed-id="${seed.id}">
            <div class="card-img-container">
                <img src="${seed.image ? `https://res.cloudinary.com/dg0ssec7u/image/upload/${seed.image}.webp` : '/static/default_image.jpg'}" class="card-img-top" alt="${seed.name}">
                ${seed.discount > 0 ? '<span class="discount-label">Discounted</span>' : ''}
            </div>
            <div class="card-body">
                <h2 class="card-title h5">${seed.name}</h2>
                <p class="card-text"><strong>Scientific Name:</strong> ${seed.scientific_name}</p>
                <p class="card-text"><strong>Planting Months:</strong> ${seed.planting_months_from} to ${seed.planting_months_to}</p>
                <p class="card-text"><strong>Flowering Months:</strong> ${seed.flowering_months_from} to ${seed.flowering_months_to}</p>
                <p class="card-text">
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

            if (!modal) {
                console.error('Modal element not found.');
                return;
            }

            // Toggle the modal visibility using a class
            modal.classList.toggle('modal-visible');

            console.log('Modal visibility toggled. Current display style:', modal.style.display);
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

function displaySearchResultsSeedDetails(seed) {
    const seedDetailsContent = document.getElementById('search-seed-details-content');
    const seedDetailsModal = document.getElementById('search-seed-details-modal');

    if (!seedDetailsContent) {
        console.error('Element with ID "search-seed-details-content" not found.');
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
                seedDetailsModal.style.display = 'none'; // Hide the seed details card
                isSeedDetailsVisible = false; // Update the visibility flag
            }
        });
    }

    // Show the seed details modal
    if (seedDetailsModal) {
        seedDetailsModal.style.display = 'block'; // Ensure the modal is visible
        isSeedDetailsVisible = true; // Update the visibility flag
    }
}



function attachSeedCardEventListeners() {
    document.querySelectorAll('.search-seed-card').forEach(card => {
        card.addEventListener('click', (event) => {
            const seedId = card.getAttribute('data-seed-id');
            const seed = getSeedFromLocalStorage(seedId);

            if (seed) {
                displaySearchResultsSeedDetails(seed);
                showSearchDetailsModal();
            } else {
                console.error('Seed not found in local storage.');
            }
        });
    });
}

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

            console.log(`Adding Seed ID ${seedId} to cart with quantity ${quantity}`);
            console.log(`Image URL: ${imageUrl}`);
            console.log('Seed details:', seed);
            console.log('Discounted Price:', seed.discount > 0 ? (seed.price - (seed.price * seed.discount / 100)).toFixed(2) : seed.price);

            if (seed) {
                console.log('Before adding to cart:', getCartFromLocalStorage()); // Log cart state before addition
                addToCart(seed, quantity, imageUrl);
                updateCartUI(); // Ensure the cart UI is updated after adding the item
                try {
                    await sendToCart(seedId, quantity, seed);
                    console.log('Item sent to server successfully.');
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

// Close message when clicking on the close button
document.addEventListener('click', (event) => {
    if (event.target.classList.contains('btn-close-message')) {
        hideItemAddedMessage();
    }
});
document.addEventListener('DOMContentLoaded', function () {
    // Handle close button clicks
    const closeButtons = document.querySelectorAll('.close-button-container');
    closeButtons.forEach(function (button) {
        button.addEventListener('click', function () {
            const message = this.closest('.message-container');
            if (message) {
                message.style.display = 'none'; // Hide the message
            }
        });
    });


});

document.addEventListener('DOMContentLoaded', (event) => {
    
    var chatIcon = document.getElementById('chatIcon');
    if (chatIcon) {
        chatIcon.addEventListener('click', function (event) {
            console.log('Chat icon clicked');
            // Uncomment below line to log href attribute
            // console.log('Redirecting to:', chatIcon.href);
        });
    }
});





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




document.addEventListener('DOMContentLoaded', () => {
    const viewCartButton = document.getElementById('cart-button');

    if (viewCartButton) {
        viewCartButton.addEventListener('click', () => {
            window.location.href = '/cart/'; // Redirect to cart page
        });
        console.log("Cart button found, event listener attached.");
    }
});
