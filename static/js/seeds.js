import {
    getCartFromLocalStorage
} from './utils.js';
import {
    sendToCart
} from './control.js';

export function displaySeeds({
    category = '',
    sort = '',
    inStock = undefined,
    discounted = undefined,
    currentPage = 1, // New parameter for the current page
    itemsPerPage = 9 // New parameter for items per page
} = {}) {
    const seedsData = JSON.parse(localStorage.getItem('seeds_data')) || [];
    const seedsContainer = document.getElementById('seeds-container');

    if (!seedsContainer) {
        console.error('Element with ID "seeds-container" not found.');
        return;
    }

    const rowElement = seedsContainer.querySelector('.row');
    if (!rowElement) {
        console.error('Element with class "row" not found inside seeds-container.');
        return;
    }

    seedsContainer.style.display = 'block';

    // Apply filters
    let filteredSeeds = seedsData;

    // Apply discount filter
    if (discounted === true) {
        filteredSeeds = filteredSeeds.filter(seed => parseFloat(seed.discount) > 0.00);
    }

    if (inStock !== undefined) {
        filteredSeeds = filteredSeeds.filter(seed => seed.is_in_stock === inStock);
    }

    if (category) {
        filteredSeeds = filteredSeeds.filter(seed => seed.category === category || category === '');
    }

    // Apply sorting
    if (sort === 'price_asc') {
        filteredSeeds.sort((a, b) => a.price - b.price);
    } else if (sort === 'price_desc') {
        filteredSeeds.sort((a, b) => b.price - a.price);
    } else if (sort === 'latest') {
        filteredSeeds.sort((a, b) => new Date(b.date_added) - new Date(a.date_added));
    } else if (sort === 'discount') {
        filteredSeeds.sort((a, b) => b.discount - a.discount);
    }

    // Pagination calculations
    const totalItems = filteredSeeds.length;
    const totalPages = Math.ceil(totalItems / itemsPerPage);
    const startIdx = (currentPage - 1) * itemsPerPage;
    const endIdx = startIdx + itemsPerPage;
    const seedsToDisplay = filteredSeeds.slice(startIdx, endIdx);

    rowElement.innerHTML = '';

    if (seedsToDisplay.length === 0) {
        rowElement.innerHTML = '<p>No seeds available based on the selected filters.</p>';
        return;
    }

    seedsToDisplay.forEach(seed => {
        const seedElement = document.createElement('div');
        seedElement.className = 'col-12 col-md-6 col-lg-4 mb-4';

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

        seedElement.innerHTML = seedHTML;
        rowElement.appendChild(seedElement);
    });

    // Create pagination controls
    let paginationControls = document.getElementById('pagination-controls');
    if (!paginationControls) {
        paginationControls = document.createElement('div');
        paginationControls.id = 'pagination-controls';
        paginationControls.className = 'pagination-controls';
        seedsContainer.appendChild(paginationControls);
    } else {
        // Clear existing buttons
        paginationControls.innerHTML = '';
    }

    // Generate pagination buttons
    for (let i = 1; i <= totalPages; i++) {
        const pageButton = document.createElement('button');
        pageButton.textContent = i;
        pageButton.className = 'page-button';

        // Set default style for all buttons
        pageButton.style.backgroundColor = 'transparent';
        pageButton.style.border = 'none';
        pageButton.style.color = 'white';
        pageButton.style.fontSize = '1.2em';
        pageButton.style.cursor = 'pointer';
        pageButton.style.margin = '0 5px';
        pageButton.style.padding = '5px 10px';
        pageButton.style.textDecoration = 'none';

        // Style for the active button
        if (i === currentPage) {
            pageButton.classList.add('active');
            pageButton.style.textDecoration = 'underline';
            pageButton.style.color = 'white';
        }

        pageButton.addEventListener('click', () => {
            displaySeeds({
                category,
                sort,
                inStock,
                discounted,
                currentPage: i,
                itemsPerPage
            });
        });

        paginationControls.appendChild(pageButton);
    }

    seedsContainer.appendChild(paginationControls);

    // Attach other event listeners if needed
    attachEventListeners();
}


document.addEventListener('DOMContentLoaded', function () {

    const cartData = JSON.parse(localStorage.getItem('cart'));
    const cartButton = document.getElementById('cart-button');

    if (cartData && Array.isArray(cartData.items) && cartData.items.length > 0) {
        // Show the cart button if there are items in the cart
        if (cartButton) {
            cartButton.style.display = 'block'; // Show cart button
            console.log('Cart button is now visible.');
        }
    } else {
        // Hide the cart button if the cart is empty or undefined
        if (cartButton) {
            cartButton.style.display = 'none'; // Hide cart button
            console.log('Cart button is now hidden.');
        }
    }

    document.querySelectorAll('.filter-buttons .custom-buttons').forEach(button => {
        button.addEventListener('click', function () {
            console.log("FILTER CLICKED");
            const category = this.dataset.category;

            // Update active class for filter buttons
            document.querySelectorAll('.filter-buttons .custom-buttons').forEach(btn => {
                btn.classList.remove('active');
            });
            this.classList.add('active');

            // Call displaySeeds with the selected category
            displaySeeds({
                category
            });
        });
    });

    // For sorting buttons
    document.querySelectorAll('.sorting-buttons button').forEach(button => {
        button.addEventListener('click', function (e) {
            e.preventDefault(); // Prevent default button behavior

            const sort = this.dataset.sort; // Get the sort value from the data attribute

            // Update active class for sorting buttons
            document.querySelectorAll('.sorting-buttons button').forEach(btn => {
                btn.classList.remove('active');
            });
            this.classList.add('active'); // Add active class to the clicked button

            // Call displaySeeds with the selected sort option
            displaySeeds({
                sort
            });
        });
    });
});


function attachEventListeners() {
    // Attach click event listener to seed cards for viewing details
    document.querySelectorAll('.seed-card').forEach(card => {
        card.addEventListener('click', (event) => {
            const seedId = card.getAttribute('data-seed-id');
            const seed = getSeedFromLocalStorage(seedId);

            if (seed) {
                console.log(`Seed card clicked. Seed ID: ${seedId}`, seed);
                displaySeedDetails(seed);
                showModal();
            } else {
                console.error('Seed not found in local storage.', seedId);
            }
        });
    });

    // Attach click event listener to "Add to Cart" buttons
    document.querySelectorAll('.add-to-cart-button').forEach(button => {
        button.addEventListener('click', async (event) => {
            event.stopPropagation(); // Prevent triggering the card click event

            const seedId = button.getAttribute('data-seed-id');
            const quantity = 1; // Default quantity

            const seedElement = button.closest('.seed-card');
            const imageUrl = seedElement.querySelector('.card-img-top').getAttribute('src');
            const seed = getSeedFromLocalStorage(seedId);

           

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
// Add item to cart
function addToCart(seed, quantity = 1) {
    let cartData = getCartFromLocalStorage(); // Fetch current cart data
    const cartButton = document.getElementById('cart-button');
    cartButton.style.display = 'block'; // Hide cart button
    cartButton.classList.add('fancy');

    // Remove the fancy class after the animation is done
    setTimeout(() => {
        cartButton.classList.remove('fancy');
    }, 1500);
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


// Function to get a seed from local storage
function getSeedFromLocalStorage(seedId) {
    const seeds = JSON.parse(localStorage.getItem('seeds_data')) || [];
    return seeds.find(seed => seed.id === parseInt(seedId, 10));
}


// Function to display seed details
function displaySeedDetails(seed) {
    const seedDetailsContent = document.getElementById('seed-details-content');

    if (!seedDetailsContent) {
        console.error('Element with ID "seed-details-content" not found.');
        return;
    }

    seedDetailsContent.innerHTML = `
        <div 
            style="background-image: url('${seed.image ? `https://res.cloudinary.com/dg0ssec7u/image/upload/${seed.image}.webp` : '/static/default_image.jpg'}'); background-size: cover; width: 100%;" >
            <h1>${seed.name}</h1>
            <div class="seed-details-content-text">
            <p><strong>Scientific Name:</strong> ${seed.scientific_name}</p>
            <p><strong>Description:</strong> ${seed.description}</p>
            <p><strong>Planting Months:</strong> ${seed.planting_months_from} to ${seed.planting_months_to}</p>
            <p><strong>Flowering Months:</strong> ${seed.flowering_months_from} to ${seed.flowering_months_to}</p>
            <p><strong>Sun Preference:</strong> ${seed.sun_preference}</p>
            <p><strong>Price:</strong> $${seed.price}</p>
            ${seed.discount > 0 ? `<p><strong>Discount:</strong> ${seed.discount}%</p>
            <p><strong>Discounted Price:</strong> $${(seed.price * (1 - seed.discount / 100)).toFixed(2)}</p>` : ''}
            ${seed.is_in_stock ? 
                '<p class="card-text text-success"><strong>In Stock</strong></p>' : 
                '<p class="card-text text-danger"><strong>Out of Stock</strong></p>'}
            </div>
            <div class="details-add-button-container>
                <div class="col-md-2">
                    <button class="details-add-button btn btn-sm mt-2 ${!seed.is_in_stock ? 'out-of-stock' : ''}" 
                        data-seed-id="${seed.id}" 
                        ${seed.is_in_stock ? '' : 'disabled'}>
                        ${seed.is_in_stock ? 'Add to Cart' : 'Out of Stock'}
                    </button>
                </div>
            </div>
        </div>
    `;

    // Add event listener for the "Add to Cart" button in seed details
    const addToCartButton = seedDetailsContent.querySelector('button');
    if (addToCartButton) {
        addToCartButton.addEventListener('click', async (event) => {
            event.stopPropagation(); // Prevent triggering other click events

            const seedId = addToCartButton.getAttribute('data-seed-id');
            const quantity = 1; // Default quantity
            const imageUrl = seed.image ? `https://res.cloudinary.com/dg0ssec7u/image/upload/${seed.image}.webp` : '/static/default_image.jpg';

            console.log(`Adding Seed ID ${seedId} to cart with quantity ${quantity}`);
            console.log(`Image URL: ${imageUrl}`);

            // Call addToCart with the image URL
            addToCart(seed, quantity, imageUrl);
            updateCartUI();
            try {
                await sendToCart(seedId, quantity, seed);
                console.log('Item sent to server successfully.');
            } catch (error) {
                console.error('Failed to send item to server:', error);
            }
        });
    }
}


function showModal() {
    const modal = document.getElementById('seed-details-modal');
    if (modal) {
        modal.style.display = 'block';
    }
}

// Function to close the modal
export function closeModal() {
    const modal = document.getElementById('seed-details-modal');
    if (modal) {
        modal.style.display = 'none';
    }
}

// Close modal when clicking on the close button
document.querySelector('.close-modal-button').addEventListener('click', closeModal);

// Close modal when clicking outside of the modal
window.addEventListener('click', (event) => {
    const modal = document.getElementById('seed-details-modal');
    if (modal && event.target === modal) {
        closeModal();
    }
});




export function displayMessageInModal(message, item) {
    const messagesContainer = document.getElementById('add-item-messages');

    if (!messagesContainer) {
        console.error('Element with ID "add-item-messages" not found.');
        return;
    }

    // Log the details for debugging
    console.log('Displaying message in modal:', {
        message,
        item
    });

    // Base URL for image
    const baseImageUrl = 'https://res.cloudinary.com/dg0ssec7u/image/upload/';
    const defaultImageUrl = '/media/images/wild-flowers-icon.webp'; // Fallback image URL

    // Determine the full image URL
    const imageUrl = item.image ?
        (item.image.startsWith('http://') ?
            item.image.replace('http://', 'https://') :
            (item.image.startsWith('https://') ?
                item.image :
                baseImageUrl + item.image)) :
        defaultImageUrl;

    // Update background image and styles
    messagesContainer.style.backgroundImage = `url('${imageUrl}')`; // Set the background image
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
function hideItemAddedMessage() {
    const messagesContainer = document.getElementById('add-item-messages');
    if (messagesContainer) {
        messagesContainer.style.display = 'none';
    }
}



// Close message when clicking on the close button
document.addEventListener('click', (event) => {
    if (event.target.classList.contains('btn-close-message')) {
        hideItemAddedMessage();
    }
});


// Make sure the cart UI is updated on page load
window.onload = updateCartUI;