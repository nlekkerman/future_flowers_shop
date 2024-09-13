document.addEventListener('DOMContentLoaded', () => {
    // Constants
    const baseImageUrl = 'https://res.cloudinary.com/dg0ssec7u/image/upload/'; // Base image URL for Cloudinary
    const defaultImageUrl = '/media/images/wild-flowers-icon.webp'; // Default image URL if hosted on your server
    const cartContainer = document.getElementById('cart-items-container');
    const totalPriceElement = document.querySelector('.total-cart-price-value');
    const updateItemMessages = document.getElementById('update-item-messages'); // Message display div
    const deleteItemMessages = document.getElementById('delete-item-messages'); // Deletion message div

    // Function to determine if a URL is full or relative
    const isFullUrl = (url) => url.startsWith('http://') || url.startsWith('https://');

    // Function to hide a message
    const hideMessage = (element) => {
        element.classList.remove('show');
        element.classList.add('hide');
    };

    // Close button event listeners
    document.getElementById('close-update-item-messages').addEventListener('click', () => {
        hideMessage(updateItemMessages);
    });

    document.getElementById('close-delete-item-messages').addEventListener('click', () => {
        hideMessage(deleteItemMessages);
    });


    // Function to show a message with flower info
    const showMessage = (flowerInfo, backgroundImage) => {
        const messageTextElement = updateItemMessages.querySelector('.message-text');
        const name = flowerInfo?.name || 'Unknown Flower';
        const price = flowerInfo?.price ? parseFloat(flowerInfo.price).toFixed(2) : '0.00';
        const quantity = flowerInfo?.quantity || 0;
        const totalPrice = flowerInfo?.totalPrice ? parseFloat(flowerInfo.totalPrice).toFixed(2) : '0.00';

        if (messageTextElement) {
            messageTextElement.innerHTML = `
                <div class="flower-message-content">
                    <p class="flower-name">You Updated quantity for <strong>${name}</strong></p>
                    <p class="flower-price">Price: <span>$${price}</span></p>
                    <p class="flower-quantity">Quantity: <span>${quantity}</span></p>
                    <p class="flower-total">Total: <span>$${totalPrice}</span></p>
                </div>
            `;
        }

        if (backgroundImage) {
            updateItemMessages.style.backgroundImage = `url(${backgroundImage})`;
        }

        updateItemMessages.classList.add('show');

        setTimeout(() => {
            updateItemMessages.classList.remove('show');
        }, 5000);
    };

    // Function to show a confirmation message for deletion
    const showConfirmationMessage = (itemName, backgroundImage) => {
        const messageTextElement = updateItemMessages.querySelector('.message-text');
        if (messageTextElement) {
            messageTextElement.innerHTML = `
                <div class="confirmation-message-content">
                    <p><strong>${itemName}</strong> has been successfully deleted from your cart.</p>
                </div>
            `;
        }

        if (backgroundImage) {
            updateItemMessages.style.backgroundImage = `url(${backgroundImage})`;
        }

        updateItemMessages.classList.add('show');

        setTimeout(() => {
            updateItemMessages.classList.remove('show');
        }, 5000);
    };

    // Function to show a deletion confirmation message
    const showDeletionMessage = (itemName, backgroundImage, onDelete, onCancel) => {
        const messageTextElement = deleteItemMessages.querySelector('.message-text');
        if (messageTextElement) {
            messageTextElement.innerHTML = `
                <div class="delete-message-content">
                    <p>You are about to delete <strong>${itemName}</strong> from your cart.</p>
                    <div class="delete-confirm-buttons">
                        <button class="btn delete-btn">Delete</button>
                        <button class="btn cancel-btn">Cancel</button>
                    </div>
                </div>
            `;
        }

        if (backgroundImage) {
            deleteItemMessages.style.backgroundImage = `url(${backgroundImage})`;
        }

        deleteItemMessages.classList.add('show');

        const deleteBtn = deleteItemMessages.querySelector('.delete-btn');
        const cancelBtn = deleteItemMessages.querySelector('.cancel-btn');

        if (deleteBtn && cancelBtn) {
            deleteBtn.addEventListener('click', () => {
                deleteItemMessages.classList.remove('show');
                onDelete(); // Call the delete function
            });

            cancelBtn.addEventListener('click', () => {
                deleteItemMessages.classList.remove('show');
                onCancel(); // Call the cancel function
            });
        }
    };

    // Load cart from local storage
    const loadCart = () => {
        const cart = JSON.parse(localStorage.getItem('cart')) || {};
        let cartItemsHTML = '';
        let totalPrice = 0;

        for (const [seedId, cartItem] of Object.entries(cart)) {
            const seed = cartItem;
            const name = seed.name || 'Unknown Item';
            const price = seed.price ? parseFloat(seed.price) : 0;
            const quantity = seed.quantity || 1;
            const image = seed.image && !isFullUrl(seed.image) ? `${baseImageUrl}${seed.image}` : seed.image || defaultImageUrl;
            const itemTotalPrice = price * quantity;
            totalPrice += itemTotalPrice;

            const stockBadge = seed.is_in_stock
                ? '<span class="badge badge-success">In Stock</span>'
                : '<span class="badge badge-danger">Out of Stock</span>';

            cartItemsHTML += `
                <div class="cart-item">
                    <div class="item-info">
                        <img src="${image}" alt="${name}" class="item-image">
                        <p><strong>${name}</strong> ${stockBadge}</p>
                        <div class="quantity-update-display">
                            <p>Quantity:</p>
                            <input type="number" class="quantity-input" value="${quantity}" min="1" data-seed-id="${seedId}" />
                            <div class="edit-quantity-button-container">
                                <button class="btn-update-quantity" data-seed-id="${seedId}">
                                    <i class="fas fa-sync-alt"></i>
                                </button>
                                <button class="btn-delete-item" data-seed-id="${seedId}">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </div>
                        </div>
                        <p>Price: $${price.toFixed(2)}</p>
                        <p>Total: $${itemTotalPrice.toFixed(2)}</p>
                    </div>
                </div>
            `;
        }
        updateCartTotal();
        cartContainer.innerHTML = cartItemsHTML;
        totalPriceElement.textContent = `$${totalPrice.toFixed(2)}`;

        console.log('Cart loaded successfully. Total price:', totalPrice.toFixed(2));
    };

    // Update quantity handler
    const updateQuantity = (seedId, newQuantity) => {
        const cart = JSON.parse(localStorage.getItem('cart')) || {};
        
        if (cart[seedId]) {
            const oldQuantity = cart[seedId].quantity;
            cart[seedId].quantity = parseInt(newQuantity, 10);
            
            localStorage.setItem('cart', JSON.stringify(cart));
            
            const updatedItem = cart[seedId];
            const flowerInfo = {
                name: updatedItem.name || 'Unknown Flower',
                price: updatedItem.price ? parseFloat(updatedItem.price) : 0,
                quantity: updatedItem.quantity || 0,
                totalPrice: updatedItem.price ? (parseFloat(updatedItem.price) * updatedItem.quantity).toFixed(2) : '0.00'
            };

            showMessage(flowerInfo, updatedItem.image);

            console.log(`Updated quantity for seedId ${seedId}: oldQuantity=${oldQuantity}, newQuantity=${newQuantity}`);
            
            loadCart(); // Refresh cart display
        } else {
            console.log(`Item with seedId ${seedId} not found in the cart.`);
        }
    };

    // Delete item handler
    const deleteItem = (seedId) => {
        const cart = JSON.parse(localStorage.getItem('cart')) || {};
        if (cart[seedId]) {
            console.log(`Preparing to delete item with seedId ${seedId} from the cart.`);
            const itemImage = isFullUrl(cart[seedId].image) ? cart[seedId].image : `${baseImageUrl}${cart[seedId].image}`;
            const itemName = cart[seedId].name || 'Unknown Item';

            // Show deletion confirmation message
            showDeletionMessage(itemName, itemImage, () => {
                // Proceed with deletion
                delete cart[seedId];
                localStorage.setItem('cart', JSON.stringify(cart));

                // Show confirmation message
                showConfirmationMessage(itemName, itemImage);

                loadCart(); // Refresh cart display
            }, () => {
                console.log('Deletion canceled.');
            });
        } else {
            console.log(`Item with seedId ${seedId} not found in the cart.`);
        }
    };

    // Event delegation for update and delete buttons
    cartContainer.addEventListener('click', (event) => {
        const target = event.target.closest('[data-seed-id]');
        if (target) {
            const seedId = target.getAttribute('data-seed-id');
            if (target.classList.contains('btn-update-quantity')) {
                const quantityInput = cartContainer.querySelector(`.quantity-input[data-seed-id="${seedId}"]`);
                const newQuantity = quantityInput.value;
                console.log(`Update button clicked for seedId ${seedId}. New quantity: ${newQuantity}`);
                updateQuantity(seedId, newQuantity);
                updateCartTotal();
            } else if (target.classList.contains('btn-delete-item')) {
                console.log(`Delete button clicked for seedId ${seedId}.`);
                deleteItem(seedId);

            }
        }
    });

    // Initial load of the cart
    loadCart();
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
document.addEventListener('DOMContentLoaded', () => {
    const checkoutButton = document.getElementById('go-to-checkout-button');

    if (checkoutButton) {
        checkoutButton.addEventListener('click', () => {
            window.location.href = '/checkout/';
        });
    }
});