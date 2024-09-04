import {
    fetchAndStoreSeeds,
    fetchAndStoreCart
} from './control.js';

// Display Seeds function in seeds.js
export function displaySeeds() {
    const seedsData = JSON.parse(localStorage.getItem('seeds_data')) || [];
    const seedsContainer = document.getElementById('seeds-container');

    if (!seedsContainer) {
        console.error('Element with ID "seeds-container" not found.');
        return;
    }

    seedsContainer.style.display = 'block';

    if (seedsData.length === 0) {
        seedsContainer.querySelector('.row').innerHTML = '<p>No seeds available.</p>';
        return;
    }

    seedsContainer.querySelector('.row').innerHTML = '';

    seedsData.forEach(seed => {
        const seedElement = document.createElement('div');
        seedElement.className = 'col-12 col-md-6 col-lg-4 mb-4';

        // Construct the seed HTML
        let seedHTML = `
            <div class="seed-card h-100" id="seed-card-${seed.id}">
                <a href="seed_details/${seed.id}" class="card-link">
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
                        ${seed.in_stock > 5 ? '<p class="card-text text-success"><strong>In stock:</strong> ' + seed.in_stock + '</p>' :
                            (seed.in_stock <= 5 && seed.in_stock > 0 ? '<p class="card-text text-warning"><strong>Hurry! Only ' + seed.in_stock + ' left in stock!</strong></p>' :
                                '<p class="card-text text-danger"><strong>Out of Stock</strong></p>')}
                    </div>
                </a>
                <div class="card-footer text-center">
                    <button class="btn add-to-cart-button" data-seed-id="${seed.id}" ${seed.in_stock === 0 ? 'disabled' : ''}>
                        ${seed.in_stock === 0 ? 'Out of Stock' : 'Add to Cart'}
                    </button>
                </div>
            </div>
        `;

        seedElement.innerHTML = seedHTML;
        seedsContainer.querySelector('.row').appendChild(seedElement);
    });

    // Attach event listeners to the "Add to Cart" buttons
    document.querySelectorAll('.add-to-cart-button').forEach(button => {
        button.addEventListener('click', (event) => {
            const seedId = event.target.getAttribute('data-seed-id');
            const quantity = 1; // Default quantity, you can modify this based on your needs
            addToCart(seedId, quantity);
        });
    });
}


async function addToCart(seedId, quantity) {
    try {
        const response = await fetch(`/cart/add/${seedId}/`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRFToken': getCsrfToken() // Make sure to include the CSRF token
            },
            body: JSON.stringify({
                quantity
            })
        });

        if (!response.ok) {
            throw new Error(`Server error: ${response.statusText}`);
        }

        const data = await response.json();
        console.log('Server response:', data);
        displayMessage("You Are Going There", data.success);



        if (data.success) {
            // Fetch and update seeds and cart
            await fetchAndStoreSeeds(); // Fetch and store updated seeds
            await fetchAndStoreCart(); // Fetch and store updated cart
            // Display message
            displayMessage(data.message, data.success);
            // Refresh UI
            displaySeeds(); // Update seeds display

        }

    } catch (error) {
        console.error('Error adding to cart:', error);
        displayMessage('An error occurred while adding the item to the cart.', false);
    }
}

// Helper function to get CSRF token from the document
function getCsrfToken() {
    const csrfTokenElement = document.querySelector('meta[name="csrf-token"]');
    return csrfTokenElement ? csrfTokenElement.getAttribute('content') : '';
}

// Function to display messages
function displayMessage(message, isSuccess) {
    const messageContainer = document.getElementById('add-item-messages');
    if (messageContainer) {
        // Set the container to be visible
        messageContainer.style.display = 'block';

        // Set the message HTML content with a close button
        messageContainer.innerHTML = `
            <div class="alert ${isSuccess ? 'alert-success' : 'alert-danger'} alert-dismissible fade show" role="alert">
                ${message}
                <button type="button" class="btn-close" aria-label="Close"></button>
            </div>
        `;

        // Add event listener for the close button
        const closeButton = messageContainer.querySelector('.btn-close');
        if (closeButton) {
            closeButton.addEventListener('click', () => {
                // Hide the message container when the close button is clicked
                messageContainer.style.display = 'none';
                messageContainer.innerHTML = ''; // Clear the message content
            });
        }
    }
}