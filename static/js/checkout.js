
document.addEventListener('DOMContentLoaded', async () => {
    let cart;
    try {
        const response = await fetch('/syncmanager/api/get_cart/');
        if (!response.ok) {
            throw new Error('Network response was not ok: ' + response.statusText);
        }
        
        cart = await response.json();
        if (!cart || typeof cart !== 'object' || !Array.isArray(cart.items)) {
            console.error('CART DATA IS NOT IN THE EXPECTED FORMAT:', cart);
            return;
        }

    } catch (error) {
        console.error('ERROR FETCHING CART DATA:', error);
        return;
    }
 
    populateCheckout(cart);
   
});


function populateCheckout(cart) {
    const checkoutItemsContainer = document.getElementById('checkout-items-container');
    const cartCount = document.getElementById('cart-count');
    const orderTotalElement = document.getElementById('order-total');
    const deliveryFeeElement = document.getElementById('delivery-fee');
    const grandTotalElement = document.getElementById('grand-total');
    const cartDataInput = document.getElementById('cart-data');
    const checkoutForm = document.getElementById('payment-form');

    if (!checkoutItemsContainer || !cartCount || !orderTotalElement || !deliveryFeeElement || !grandTotalElement || !cartDataInput || !checkoutForm) {
        console.error('ONE OR MORE DOM ELEMENTS ARE MISSING.');
        return;
    }

    let orderTotal = 0;
    const deliveryFee = 5.00; 
    checkoutItemsContainer.innerHTML = '';

    cart.items.forEach(item => {
        if (!item || !item.seed) {
            console.error('INVALID ITEM DATA:', item);
            return;
        }

        checkoutItemsContainer.insertAdjacentHTML('beforeend', renderCartItem(item));
        orderTotal += item.quantity * parseFloat(item.seed.price);
    });

    cartCount.textContent = cart.items.length; 
    orderTotalElement.textContent = `$${orderTotal.toFixed(2)}`; 

   
    if (orderTotal > 50) {
        deliveryFeeElement.innerHTML = '<span style="color: green; font-weight: bold; text-align: left; margin-right: 10px;">FREE</span>';
        grandTotalElement.textContent = `$${orderTotal.toFixed(2)}`;
    } else {
        deliveryFeeElement.textContent = `$${deliveryFee.toFixed(2)}`;
        grandTotalElement.textContent = `$${(orderTotal + deliveryFee).toFixed(2)}`;
    }

   
}


function renderCartItem(item) {
    const baseImageUrl = 'https://res.cloudinary.com/dg0ssec7u/image/upload/';
    const defaultImageUrl = '/media/images/wild-flowers-icon.webp';

    const seedId = item.seed.id;
    const name = item.seed.name;
    const itemQuantity = item.quantity;
    const itemPrice = parseFloat(item.seed.price);
    const itemTotalPrice = itemQuantity * itemPrice;

    const itemImage = item.seed.image ? 
        item.seed.image.startsWith('http://') ? 
        item.seed.image.replace('http://', 'https://') : 
        baseImageUrl + item.seed.image : 
        defaultImageUrl;

    return `
        <div class="cart-item">
           <div class="item-info">
                <!-- New div wrapping the image and the name -->
                <div class="image-name-container">
                    <img src="${itemImage}" alt="${name}" class="item-image" />
                    <p class="item-font"><strong>${name}</strong></p>
                </div>

                <!-- Existing quantity and price details -->
                <div class="quantity-update-display">
                    <p class="item-font">Quantity:</p>
                    <p class="item-font text-center">${itemQuantity}</p>
                </div>
                <p class="item-font">Price: $${itemPrice.toFixed(2)}</p>
                <p>Total: <strong class="price-color-green">$${itemTotalPrice.toFixed(2)}</strong></p>
            </div>
        </div>
    `;
}

function deleteCartItem(cart, seedId) {
    const cartId = cart.id; // Assuming cart object contains the cart ID

    // Send POST request to the server to delete the item
    fetch('/cart/api/delete_item/', {  // Update to correct URL
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-CSRFToken': getCSRFToken(), // Ensure CSRF token is included
        },
        body: JSON.stringify({
            cart_id: cartId,
            seed_id: seedId,
        }),
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            // Remove the item from the cart array
            cart.items = cart.items.filter(item => item.seed.id !== seedId);
            
            // Re-populate the checkout page with the updated cart
            populateCheckout(cart);
        } else {
            console.error('Error deleting item:', data.error);
        }
    })
    .catch(error => {
        console.error('Error:', error);
    });
}


