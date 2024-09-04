// controls.js

import { updateCart } from './cart.js';
import { displaySeeds, syncSeedsWithDB } from './seeds.js';

document.addEventListener('DOMContentLoaded', () => {
    displaySeeds(); // Display seeds on page load

    // Event listener for add-to-cart button
    document.addEventListener('click', (event) => {
        if (event.target.classList.contains('add-to-cart')) {
            const button = event.target;
            const seedId = button.getAttribute('data-id');
            const seedName = button.getAttribute('data-name');
            const seedPrice = button.getAttribute('data-price');
            const seedImage = button.getAttribute('data-image');
            const quantity = parseInt(button.getAttribute('data-quantity'), 10);

            // Update cart
            updateCart(seedId, seedName, seedPrice, seedImage, quantity);

            // Show message
            displayMessage('Item added', 'success');

            // Optionally refresh seeds data if needed
            syncSeedsWithDB(); 
        }
    });

    // Close message functionality
    document.getElementById('close-message').addEventListener('click', () => {
        document.getElementById('add-item-messages').style.display = 'none';
    });
});

function displayMessage(message, type) {
    const addItemMessagesContainer = document.getElementById('add-item-messages');
    const itemMessage = document.getElementById('item-message');
    const itemDetails = document.getElementById('item-details');
    const itemImage = document.getElementById('item-image');
    const itemName = document.getElementById('item-name');
    const itemPrice = document.getElementById('item-price');
    const itemQuantity = document.getElementById('item-quantity');

    addItemMessagesContainer.style.display = 'block';
    itemMessage.textContent = message;
    itemDetails.style.display = 'block'; // Show details

    // Update the message and item details
    itemMessage.textContent = message;
    itemDetails.style.display = 'block';

    // Hide the message after 10 seconds
    setTimeout(() => {
        addItemMessagesContainer.style.display = 'none';
    }, 10000);
}
