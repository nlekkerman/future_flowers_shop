// Function to display seeds with filtering and sorting
export function displaySeeds({ category = '', sort = '', inStock = undefined, discounted = undefined } = {}) {
    const seedsData = JSON.parse(localStorage.getItem('seeds_data')) || [];
    const seedsContainer = document.getElementById('seeds-container');

    if (!seedsContainer) {
        console.error('Element with ID "seeds-container" not found.');
        return;
    }

    seedsContainer.style.display = 'block';

    // Apply filters
    let filteredSeeds = seedsData;

    if (inStock !== undefined) {
        filteredSeeds = filteredSeeds.filter(seed => seed.is_in_stock === inStock);
    }

    if (discounted !== undefined) {
        filteredSeeds = filteredSeeds.filter(seed => (seed.discount > 0) === discounted);
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

    if (filteredSeeds.length === 0) {
        seedsContainer.querySelector('.row').innerHTML = '<p>No seeds available based on the selected filters.</p>';
        return;
    }

    seedsContainer.querySelector('.row').innerHTML = '';

    filteredSeeds.forEach(seed => {
        console.log(`Seed Name: ${seed.name}, In Stock: ${seed.is_in_stock}, Stock Quantity: ${seed.in_stock}`);

        const seedElement = document.createElement('div');
        seedElement.className = 'col-12 col-md-6 col-lg-4 mb-4';

        // Construct the seed HTML
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
                    <p class="card-text"><strong>Price:</strong> $${seed.price}</p>
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
        seedsContainer.querySelector('.row').appendChild(seedElement);
    });

    // Attach event listeners to the seed cards for viewing details
    document.querySelectorAll('.seed-card').forEach(card => {
        card.addEventListener('click', (event) => {
            const seedId = card.getAttribute('data-seed-id');
            const seed = getSeedFromLocalStorage(seedId);
            
            if (seed) {
                displaySeedDetails(seed);
                showModal();
            } else {
                console.error('Seed not found in local storage.');
            }
        });
    });

    document.querySelectorAll('.add-to-cart-button').forEach(button => {
        button.addEventListener('click', (event) => {
            event.stopPropagation(); // Prevent triggering the card click event
            
            const seedId = button.getAttribute('data-seed-id');
            const quantity = 1; // Default quantity
    
            // Find the seed element to get the image URL
            const seedElement = button.closest('.seed-card');
            const imageUrl = seedElement.querySelector('.card-img-top').getAttribute('src');
    
            console.log(`Adding Seed ID ${seedId} to cart with quantity ${quantity}`);
            console.log(`Image URL: ${imageUrl}`);
            
            // Call addToCart with the image URL
            addToCart(seedId, quantity, imageUrl);
        });
    });


// Handling filter button clicks
document.querySelectorAll('#filter-buttons .filter-button').forEach(button => {
    button.addEventListener('click', () => {
        const category = button.getAttribute('data-category');
        
        // Update the active state of filter buttons
        document.querySelectorAll('#filter-buttons .filter-button').forEach(btn => btn.classList.remove('active'));
        button.classList.add('active');
        
        // Retrieve the current sort option (default or active)
        const sort = document.querySelector('.sorting-buttons .custom-buttons.active').getAttribute('data-sort') || '';
        
        // Call displaySeeds with the selected filter and sort options
        displaySeeds({ category, sort });
    });
});

// Handling sort button clicks
document.querySelectorAll('.sorting-buttons a').forEach(button => {
    button.addEventListener('click', (event) => {
        event.preventDefault(); // Prevent the default link behavior
        
        const sort = button.getAttribute('data-sort');
        
        // Update the active state of sorting buttons
        document.querySelectorAll('.sorting-buttons a').forEach(btn => btn.classList.remove('active'));
        button.classList.add('active');
        
        // Retrieve the selected category (default or active)
        const category = document.querySelector('#filter-buttons .filter-button.active').getAttribute('data-category') || '';
        
        // Call displaySeeds with the selected sort and filter options
        displaySeeds({ category, sort });
    });
});
}

console.log('Seeds Data:', JSON.parse(localStorage.getItem('seeds_data')));

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
        <div class="container"
            style="background-image: url('${seed.image ? `https://res.cloudinary.com/dg0ssec7u/image/upload/${seed.image}.webp` : '/static/default_image.jpg'}'); background-size: cover; width: 100%;" >
            <h1>${seed.name}</h1>
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
            <div class="row">
                <div class="col-md-2">
                    <button class="btn btn-sm mt-2 ${!seed.is_in_stock ? 'out-of-stock' : ''}" 
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
        addToCartButton.addEventListener('click', (event) => {
            event.stopPropagation(); // Prevent triggering other click events
            
            const seedId = addToCartButton.getAttribute('data-seed-id');
            const quantity = 1; // Default quantity
            const imageUrl = seed.image ? `https://res.cloudinary.com/dg0ssec7u/image/upload/${seed.image}.webp` : '/static/default_image.jpg';

            console.log(`Adding Seed ID ${seedId} to cart with quantity ${quantity}`);
            console.log(`Image URL: ${imageUrl}`);
            
            // Call addToCart with the image URL
            addToCart(seedId, quantity, imageUrl);
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


// Example displayMessageInModal function
export function displayMessageInModal(message, item) {
    const messagesContainer = document.getElementById('add-item-messages');
    
    if (!messagesContainer) {
        console.error('Element with ID "add-item-messages" not found.');
        return;
    }

    // Log the details for debugging
    console.log('Displaying message in modal:', { message, item });

    // Fetch image URL based on item ID
    const imageUrl = item.image;

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
export function hideItemAddedMessage() {
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
