
document.addEventListener('DOMContentLoaded', async () => {
    console.log('DOM CONTENT LOADED. STARTING CHECKOUT PROCESS...');
    
    let cart;

    try {
        const response = await fetch('/syncmanager/api/get_cart/');
        if (!response.ok) {
            throw new Error('Network response was not ok: ' + response.statusText);
        }
        
        cart = await response.json();
        console.log('FETCHED CART DATA:', cart);

        // Validate cart data
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

    // Check for missing DOM elements
    if (!checkoutItemsContainer) console.error('Missing: checkout-items-container');
    if (!cartCount) console.error('Missing: cart-count');
    if (!orderTotalElement) console.error('Missing: order-total');
    if (!deliveryFeeElement) console.error('Missing: delivery-fee');
    if (!grandTotalElement) console.error('Missing: grand-total');
    if (!cartDataInput) console.error('Missing: cart-data');
    if (!checkoutForm) console.error('Missing: checkout-form');

    // Return early if any elements are missing
    if (!checkoutItemsContainer || !cartCount || !orderTotalElement || !deliveryFeeElement || !grandTotalElement || !cartDataInput || !checkoutForm) {
        console.error('ONE OR MORE DOM ELEMENTS ARE MISSING.');
        return;
    }

    let orderTotal = 0;
    const deliveryFee = 5.00; // Default delivery fee

    checkoutItemsContainer.innerHTML = ''; // Clear previous items

    // Iterate over cart items
    cart.items.forEach(item => {
        if (!item || !item.seed) {
            console.error('INVALID ITEM DATA:', item);
            return;
        }

        checkoutItemsContainer.insertAdjacentHTML('beforeend', renderCartItem(item));
        orderTotal += item.quantity * parseFloat(item.seed.price);
    });

    cartCount.textContent = cart.items.length; // Update cart count
    orderTotalElement.textContent = `$${orderTotal.toFixed(2)}`; // Update order total

    // Update delivery fee and grand total based on order total
    if (orderTotal > 50) {
        deliveryFeeElement.innerHTML = '<span style="color: green; font-weight: bold; text-align: left; margin-right: 10px;">FREE</span>';
        grandTotalElement.textContent = `$${orderTotal.toFixed(2)}`;
    } else {
        deliveryFeeElement.textContent = `$${deliveryFee.toFixed(2)}`;
        grandTotalElement.textContent = `$${(orderTotal + deliveryFee).toFixed(2)}`;
    }

    // Handle form submission
    checkoutForm.addEventListener('submit', function (e) {
        e.preventDefault();
        cartDataInput.value = JSON.stringify(cart);
        console.log('FORM SUBMITTED WITH CART DATA:', cartDataInput.value);
        this.submit();
    });
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
                <img src="${itemImage}" alt="${name}" class="item-image"  />
                <p class="item-font"><strong>${name}</strong></p>
                <div class="quantity-update-display">
                    <p class="item-font">Quantity:</p>
                    <p class="item-font text-center">${itemQuantity}</p>
                </div>
                <p class="item-font">Price: $${itemPrice.toFixed(2)}</p>
                <p >Total: $${itemTotalPrice.toFixed(2)}</p>
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
