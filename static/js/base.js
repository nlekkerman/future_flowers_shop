let isSeedDetailsVisible = false; // Flag to track seed details modal visibility

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

export function addToCart(seedId, quantity, imageUrl) {
    try {
        // Retrieve the seeds data
        const seedsData = JSON.parse(localStorage.getItem('seeds_data')) || [];
        const seed = seedsData.find(seed => seed.id === parseInt(seedId, 10));

        if (!seed || !seed.is_in_stock) {
            console.error('Seed is out of stock or not found.');
            return;
        }

        // Retrieve the existing cart
        const cart = JSON.parse(localStorage.getItem('cart')) || {};

        // Check if the seed item already exists in the cart
        if (!cart[seedId]) {
            // Seed item does not exist in the cart, initialize it
            cart[seedId] = {
                id: seed.id,
                name: seed.name,
                quantity: 0, // Initialize quantity to 0
                price: seed.price,
                image: imageUrl, // Pass the image URL directly
                is_in_stock: seed.is_in_stock
            };
        }

        // Get the existing item from the cart
        const existingItem = cart[seedId];
        console.log(`Quantity of ${seed.name} before adding: ${existingItem.quantity}`);

        // Update the quantity
        existingItem.quantity += quantity;

        // Save the updated cart to local storage
        localStorage.setItem('cart', JSON.stringify(cart));

        // Log the quantity of the specific item after adding
        console.log(`Quantity of ${seed.name} after adding: ${existingItem.quantity}`);
        console.log('Updated cart item:', existingItem);

        // Display message in modal
        displayMessageInModal(`Added ${quantity} ${seed.name} to the cart.`, existingItem);
        updateCartTotal();

    } catch (error) {
        console.error('Error adding to cart:', error);
        displayMessageInModal('An error occurred while adding the item to the cart.');
    }
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


function toggleSearchResults() {
    const resultsContainer = document.getElementById('search-results-container');
    const toggleButton = document.getElementById('search-button');
    const seedDetailsModal = document.getElementById('search-seed-details-modal');

    if (resultsContainer) {
        // Toggle visibility based on the current state of the search results container
        if (resultsContainer.classList.contains('visible')) {
            // Hide the results container
            resultsContainer.classList.remove('visible');
            resultsContainer.classList.add('hidden');
            toggleButton.innerHTML = '<i class="fas fa-search"></i>'; // Reset to search icon

            // Hide the seed details modal when hiding results
            if (seedDetailsModal) {
                seedDetailsModal.style.display = 'none';
                isSeedDetailsVisible = false; // Update the flag to indicate the modal is hidden
            }
        } else {
            // Show the results container
            resultsContainer.classList.remove('hidden');
            resultsContainer.classList.add('visible');
            resultsContainer.style.marginTop = "10px"; // Add margin top

            // Update button text to "Close"
            toggleButton.innerHTML = 'Close';

            // Show the seed details modal again if it was visible before
            if (seedDetailsModal && isSeedDetailsVisible) {
                isSeedDetailsVisible = false;
                seedDetailsModal.style.display = 'block'; // Show the modal if it was open before

            }
        }
    } else {
        console.error('Results container not found.');
    }
}




let currentSeedId = null;

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
            <div class="search-seed-card h-100 d-flex flex-column justify-content-between"
                id="search-seed-card-${seed.id}"
                data-seed-id="${seed.id}"
                style="background-image: url('${backgroundImageUrl}'); background-size: cover; background-position: center; position: relative; padding: 20px; border-radius: 8px; color: white; cursor: pointer;">
                <div class="card-overlay" style="background-color: rgba(0, 0, 0, 0.6); padding: 10px; border-radius: 8px;">
                    <h2 class="card-title">${seed.name}</h2>
                </div>
                <div class="card-footer" style="text-align: center;">
                    ${seed.is_in_stock ?
                        '<p class="card-text text-success"><strong>In Stock</strong></p>' :
                        '<p class="card-text text-danger"><strong>Out of Stock</strong></p>'}
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

function displaySearchResultsSeedDetails(seed) {
    const seedDetailsContent = document.getElementById('search-seed-details-content');

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

    const addToCartButton = seedDetailsContent.querySelector('.add-to-cart-button');
    if (addToCartButton && seed.is_in_stock) {
        addToCartButton.addEventListener('click', function () {
            addToCart(seed.id, 1, seed.image);
        });
    }

    const closeButton = document.getElementById('closeSeedDetails');

    if (closeButton) {
        closeButton.addEventListener('click', () => {
            const seedDetails = document.querySelector('.seed-details');
            console.log("Jnzsdjkcnsdkjzcnvzkdjnczkjvcnzkjdvcnzdj")

            if (seedDetails) {
                console.log("Jnzsdjkcnsdkjzcnvzkdjnczkjvcnzkjdvcnzdj")
                seedDetails.style.display = 'none'; // Hide the seed details card
            }
        });
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
    document.querySelectorAll('.add-to-cart-button').forEach(button => {
        button.addEventListener('click', (event) => {
            event.stopPropagation();

            const seedId = button.getAttribute('data-seed-id');
            const quantity = 1;
            const searchSeedElement = button.closest('.search-seed-card');
            const imageUrl = searchSeedElement.querySelector('.card-img-top').getAttribute('src');

            addToCart(seedId, quantity, imageUrl);
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

                // Optionally add a red border around the input to highlight the issue
                searchInput.style.borderColor = 'red';
                // Hide the warning message after 2 seconds
                setTimeout(() => {
                    warningMessage.style.display = 'none';
                    searchInput.style.borderColor = ''; // Reset to default
                }, 1000);

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
    // Handle filtering and sorting without page reload (optional)
    document.querySelectorAll('.filter-buttons a, .sorting-buttons a').forEach(button => {
        button.addEventListener('click', function (e) {
            e.preventDefault();
            window.location.href = this.href;
        });
    });
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

// Handle the cart button click
document.addEventListener('DOMContentLoaded', () => {
    console.log('DOM fully loaded and parsed');

    const viewCartButton = document.getElementById('cart-button');
    if (viewCartButton) {
        console.log('Cart button found:', viewCartButton);

        viewCartButton.addEventListener('click', (event) => {
            console.log('Cart button clicked');
            event.preventDefault(); // Prevent default link behavior

            // Check if cart data exists in localStorage
            const cartData = localStorage.getItem('cart_data');
            if (cartData) {
                console.log('Cart data found in localStorage. Redirecting to cart page...');
                window.location.href = '/cart/'; // Navigate to the cart page
            } else {
                console.warn('No cart data found in localStorage. Displaying empty cart message.');

                // Navigate to the cart page
                window.location.href = '/cart/'; // Navigate to the cart page
            }
        });
    } else {
        console.warn('Cart button not found in the DOM');
    }
});


document.addEventListener('DOMContentLoaded', () => {
    console.log('DOM fully loaded and parsed. Updating cart total...');
    updateCartTotal();
});

function updateCartTotal() {
    const cart = JSON.parse(localStorage.getItem('cart')) || {};
    let total = 0;

    // Calculate the total from the cart items
    for (let seedId in cart) {
        if (cart.hasOwnProperty(seedId)) {
            const item = cart[seedId];
            total += item.price * item.quantity;
        }
    }

    // Update the cart total on the page
    const cartTotalElement = document.getElementById('cart-total');
    if (cartTotalElement) {
        cartTotalElement.innerText = `$${total.toFixed(2)}`;
    } else {
        console.warn('Element with ID "cart-total" not found.');
    }
}