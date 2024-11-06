import { updateQuantityOnServer, deleteCartItemOnServer } from './control.js'; 
const updateItemMessages = document.getElementById('update-item-messages');
const showMessage = (flowerInfo, backgroundImage) => {
    console.log('showMessage called');
    console.log('Flower Info:', flowerInfo);
    console.log('Background Image:', backgroundImage);

    // Use getElementById to find the element by ID
    const updateItemMessages = document.getElementById('update-item-messages');
    if (!updateItemMessages) {
        console.error('updateItemMessages element not found.');
        return;
    }

    const messageTextElement = updateItemMessages.querySelector('.message-text');
    if (!messageTextElement) {
        console.error('Message text element not found within updateItemMessages.');
        return;
    }

    const name = flowerInfo?.name || 'Unknown Flower';
    const price = flowerInfo?.price ? parseFloat(flowerInfo.price).toFixed(2) : '0.00';
    const quantity = flowerInfo?.quantity || 0;
    const totalPrice = flowerInfo?.totalPrice ? parseFloat(flowerInfo.totalPrice).toFixed(2) : '0.00';

    console.log('Message text element found:', messageTextElement);
    console.log('Setting message content:', `
        <div class="flower-message-content">
            <p class="flower-name">You updated quantity for <strong>${name}</strong></p>
            <p class="flower-price">Price: <span>$${price}</span></p>
            <p class="flower-quantity">Quantity: <span>${quantity}</span></p>
            <p class="flower-total">Total: <span>$${totalPrice}</span></p>
        </div>
    `);

    messageTextElement.innerHTML = `
        <div class="flower-message-content">
            <p class="flower-name">You updated quantity for <strong>${name}</strong></p>
            <p class="flower-price">Price: <span>$${price}</span></p>
            <p class="flower-quantity">Quantity: <span>${quantity}</span></p>
            <p class="flower-total">Total: <span>$${totalPrice}</span></p>
        </div>
    `;

    if (backgroundImage) {
        console.log('Setting background image:', backgroundImage);
        updateItemMessages.style.backgroundImage = `url(${backgroundImage})`;
    } else {
        console.log('No background image provided.');
    }

    updateItemMessages.classList.add('show');
    console.log('Added "show" class to updateItemMessages.');

    setTimeout(() => {
        updateItemMessages.classList.remove('show');
        console.log('Removed "show" class from updateItemMessages after 5 seconds.');
    }, 3000);
};
const showDeletionMessage = (itemName) => {
    console.log('showDeletionMessage called');
    
    // Use getElementById to find the element by ID
    const updateItemMessages = document.getElementById('update-item-messages');
    if (!updateItemMessages) {
        console.error('updateItemMessages element not found.');
        return;
    }

    const messageTextElement = updateItemMessages.querySelector('.message-text');
    if (!messageTextElement) {
        console.error('Message text element not found within updateItemMessages.');
        return;
    }

    const messageContent = `
        <div class="delete-message-content">
            <p><strong>${itemName}</strong> has been deleted successfully.</p>
        </div>
    `;

    messageTextElement.innerHTML = messageContent;

    updateItemMessages.classList.add('show');
    console.log('Added "show" class to updateItemMessages.');

    setTimeout(() => {
        updateItemMessages.classList.remove('show');
        console.log('Removed "show" class from updateItemMessages after 3 seconds.');
    }, 3000);
};

export function loadCart() {
    const baseImageUrl = 'https://res.cloudinary.com/dg0ssec7u/image/upload/';
    const defaultImageUrl = '/media/images/wild-flowers-icon.webp';
    const cartContainer = document.getElementById('cart-items-container');
    const totalPriceElement = document.querySelector('.total-cart-price-value');

    const deleteItemMessages = document.getElementById('delete-item-messages');

    const hideMessage = (element) => {
        element.classList.remove('show');
        element.classList.add('hide');
    };

    document.getElementById('close-update-item-messages').addEventListener('click', () => {
        hideMessage(updateItemMessages);
    });

    document.getElementById('close-delete-item-messages').addEventListener('click', () => {
        hideMessage(deleteItemMessages);
    });


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

        deleteBtn.addEventListener('click', () => {
            deleteItemMessages.classList.remove('show');
            onDelete();
        });

        cancelBtn.addEventListener('click', () => {
            deleteItemMessages.classList.remove('show');
            onCancel();
        });
    };

    // Fetch and log cart data
    const cartData = localStorage.getItem('cart');
    console.log('Fetched cart data from localStorage:', cartData);

    if (!cartData) {
        cartContainer.innerHTML = '<p>Your cart is empty.</p>';
        return;
    }

    const cart = JSON.parse(cartData);
    console.log('Parsed cart data:', cart);

    let cartItemsHTML = '';
    let totalCartPrice = 0;

    if (!cart.items || cart.items.length === 0) {
        cartItemsHTML = `
        <div class="empty-cart-message">
        <p class="display-4 text-center">Your cart is empty.</p>
        <button id="viewSeedsButton" class="btn empty-cart-message-button">Start Shopping</button>
    </div>
        `;
    } else {
        cart.items.forEach(item => {
            if (item && item.seed) {
                const seedId = item.seed.id; // Correct usage of ID
                console.log('Processing item with seed ID:', seedId);
        
                const name = item.seed.name;
                const itemQuantity = item.quantity;
                const itemPrice = parseFloat(item.seed.price); 
                const itemTotalPrice = itemQuantity * itemPrice;
                console.log('PRICEEEEEEEEEEE:  ', itemPrice);
    
                const itemImage = item.seed.image ?
                    item.seed.image.startsWith('http://') ?
                    item.seed.image.replace('http://', 'https://') :
                    baseImageUrl + item.seed.image :
                    defaultImageUrl;
        
                cartItemsHTML += `
                    <div class="cart-item">
                        <div class="item-info">
                            <img src="${itemImage}" alt="${name}" class="item-image">
                            <p><strong>${name}</strong></p>
                            <div class="quantity-update-display">
                                <p>Quantity:</p>
                                <input type="number" class="quantity-input" value="${itemQuantity}" min="1" data-seed-id="${seedId}" />
                                <div class="edit-quantity-button-container">
                                    <button class="btn-update-quantity" data-seed-id="${seedId}">
                                        <i class="fas fa-sync-alt"></i>
                                    </button>
                                    <button class="btn-delete-item" data-seed-id="${seedId}">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </div>
                            </div>
                            <p>Price: $${itemPrice.toFixed(2)}</p>
                            <p>Total: $${itemTotalPrice.toFixed(2)}</p>
                        </div>
                    </div>
                `;
        
                totalCartPrice += itemTotalPrice;  // Sum up the total price
            } else {
                console.error("Item or seed is undefined", item);
            }
        });
    }
    
    document.getElementById('viewSeedsButton').addEventListener('click', () => {
        window.location.href = '/seeds/?show_seeds=true';
    });

    cartContainer.innerHTML = cartItemsHTML;
    totalPriceElement.textContent = `$${totalCartPrice.toFixed(2)}`;

    // Attach event listeners for quantity update and item deletion
    document.querySelectorAll('.btn-update-quantity').forEach(button => {
        button.addEventListener('click', () => {
            const seedId = button.getAttribute('data-seed-id');
            console.log('Update button clicked for seed ID:', seedId);
            updateCartQuantity(seedId);

        });
    });

    // Set up event listeners for delete buttons
    document.querySelectorAll('.btn-delete-item').forEach(button => {
        button.addEventListener('click', () => {
            // Fetch seed ID and ensure it's treated as a number
            const seedId = Number(button.getAttribute('data-seed-id'));
            console.log('Delete button clicked for seed ID:', seedId);

            // Fetch the current cart data from localStorage
            const cart = getCartFromLocalStorage();

            if (!cart || !cart.items || cart.items.length === 0) {
                console.warn('No cart data found or cart is empty.');
                return;
            }

            // Find the item to delete by matching the seed ID as a number
            const itemToDelete = cart.items.find(item => item.seed.id === seedId);
            console.log('Item found for deletion:', itemToDelete);

            if (itemToDelete) {
                // Format the image URL correctly
                const baseImageUrl = 'https://res.cloudinary.com/dg0ssec7u/image/upload/';
                const imageUrl = itemToDelete.seed.image.startsWith('http') ?
                    itemToDelete.seed.image :
                    baseImageUrl + itemToDelete.seed.image;

                // Show deletion message with the correctly formatted URL
                showDeletionMessage(itemToDelete.seed.name, imageUrl, () => {
                    deleteCartItem(seedId); // Pass the correct seedId as a number
                    
                }, () => {
                    console.log('Deletion cancelled.');
                });
            } else {
                console.error('Item with seed ID not found in cart:', seedId);
            }
        });
    });

}
export async function updateCartQuantity(seedId) {
    let cart = getCartFromLocalStorage();

    const seedIdStr = String(seedId);

    const itemIndex = cart.items.findIndex(item => String(item.seed.id) === seedIdStr);
    if (itemIndex === -1) {
        console.warn('Item with seed ID not found in cart:', seedIdStr);
        return;
    }

    const quantityInput = document.querySelector(`.quantity-input[data-seed-id="${seedId}"]`);
    if (!quantityInput) {
        console.error('Quantity input not found for seed ID:', seedIdStr);
        return;
    }

    const newQuantity = parseInt(quantityInput.value, 10);
    if (newQuantity > 0) {
        const updatedItem = cart.items[itemIndex];
        updatedItem.quantity = newQuantity;
        updatedItem.total_price = newQuantity * parseFloat(updatedItem.seed.price);

        const total_price = cart.items.reduce((total, item) => total + (item.total_price || 0), 0);
        const updatedCartData = {
            id: cart.id || Date.now(),
            user: 'current_user',
            created_at: cart.created_at || new Date().toISOString(),
            updated_at: new Date().toISOString(),
            total_price: total_price.toFixed(2),
            items: cart.items
        };

        localStorage.setItem('cart', JSON.stringify(updatedCartData));
        updateCartTotal();
        // Reload the cart UI
        loadCart();

          // Construct the image URL correctly
          const baseImageUrl = 'https://res.cloudinary.com/dg0ssec7u/image/upload/';
          const imagePath = updatedItem.seed.image || '';
          const imageUrl = imagePath.startsWith('http://') ? imagePath.replace('http://', 'https://') :
                           imagePath.startsWith('https://') ? imagePath :
                           baseImageUrl + imagePath;
  
          // Prepare flower info
          const flowerInfo = {
              name: updatedItem.seed.name || 'Unknown Flower',
              price: updatedItem.seed.price ? parseFloat(updatedItem.seed.price) : 0,
              quantity: newQuantity,
              totalPrice: (parseFloat(updatedItem.seed.price) * newQuantity).toFixed(2)
          };
  
          // Show the message with the correct image URL
          showMessage(flowerInfo, imageUrl);
         // Send the updated quantity to the server
         try {
            const cartId = cart.id || Date.now(); // Use existing cart ID or generate a new one
            const result = await updateQuantityOnServer(cartId, seedId, newQuantity);
            console.log('Server response:', result);
        } catch (error) {
            console.error('Failed to update quantity on server:', error);
            // Optionally handle the error (e.g., show a message to the user)
        }
    } else {
        console.warn('Quantity must be greater than zero.');
    }
}

// Helper function to get cart data from localStorage
function getCartFromLocalStorage() {
    const cartData = localStorage.getItem('cart');
    return cartData ? JSON.parse(cartData) : {
        items: []
    };
}

export async function deleteCartItem(seedId) {
    let cart = getCartFromLocalStorage();
    const seedIdInt = parseInt(seedId, 10);

    if (!cart || !cart.items || cart.items.length === 0) {
        console.warn('No cart found or cart is empty.');
        return;
    }

    const updatedItems = cart.items.filter(item => item.seed.id !== seedIdInt);

    if (cart.items.length === updatedItems.length) {
        console.warn('No item found with seed ID:', seedIdInt);
        return;
    }

    // Prepare flower info for the message
    const itemToDelete = cart.items.find(item => item.seed.id === seedIdInt);
    const flowerName = itemToDelete.seed.name || 'Unknown Flower';

    cart.items = updatedItems;
    console.log('UPDATED CART ITEMS AFTER DELETION:', cart.items);

    // Calculate the total price after deletion
    const total_price = cart.items.reduce((total, item) => {
        const itemPrice = item.seed.discount > 0 ? parseFloat(item.seed.discounted_price) : parseFloat(item.seed.price);
        const itemTotalPrice = item.quantity * itemPrice;
        console.log(`ITEM ID: ${item.seed.id}, ITEM PRICE: ${itemPrice}, ITEM TOTAL PRICE: ${itemTotalPrice}`);
        return total + itemTotalPrice;
    }, 0);

    // Log the total price before updating local storage
    console.log('Total price after item deletion:', total_price.toFixed(2));

    const updatedCartData = {
        id: cart.id || Date.now(),
        user: 'current_user',
        created_at: cart.created_at || new Date().toISOString(),
        updated_at: new Date().toISOString(),
        total_price: total_price.toFixed(2),
        items: cart.items
    };

    localStorage.setItem('cart', JSON.stringify(updatedCartData));
    updateCartTotal();
    
    // Reload the cart UI
    loadCart();
    console.log('Item deleted successfully, UI updated.');

    // Call to server to delete the item
    await deleteCartItemOnServer(seedId);
    console.log('Item deleted successfully ON SERVER');

    // Show the deletion message after all operations
    showDeletionMessage(flowerName);
}



// Update the total price in the cart UI
function updateCartTotal() {
    // Fetch the cart data from local storage
    const cartData = getCartFromLocalStorage();

    // Validate cart data
    if (!cartData || !cartData.items) {
        console.warn('No cart data found or cart items are missing.');
        return;
    }

    // Calculate the total price
    const totalPrice = cartData.items.reduce((total, item) => {
        const itemTotalPrice = parseFloat(item.total_price) || (item.quantity * parseFloat(item.seed.price));
        return total + itemTotalPrice;
    }, 0);

    // Get the total price element and update its text content
    const cartTotalElement = document.getElementById('cart-total');
    if (cartTotalElement) {
        cartTotalElement.textContent = `$${totalPrice.toFixed(2)}`; // Format as currency
    } else {
        console.error('Cart total element not found.');
    }

    console.log('Cart total updated:', totalPrice.toFixed(2));
}


document.addEventListener('DOMContentLoaded', () => {
    loadCart(); // Load and render the cart when the page is loaded
});

document.getElementById('go-to-checkout-button').addEventListener('click', function() {
     window.location.href = "/checkout/";
});