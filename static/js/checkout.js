document.addEventListener('DOMContentLoaded', function () {
    // Retrieve cart data from localStorage
    const cart = JSON.parse(localStorage.getItem('cart')) || {};
    
    console.log('Cart data:', cart); // Log cart data to verify retrieval

    // Select DOM elements
    const checkoutItemsContainer = document.getElementById('checkout-items-container');
    const cartCount = document.getElementById('cart-count');
    const orderTotalElement = document.getElementById('order-total');
    const deliveryFeeElement = document.getElementById('delivery-fee');
    const grandTotalElement = document.getElementById('grand-total');
    const cartDataInput = document.getElementById('cart-data');
    const checkoutForm = document.getElementById('checkout-form');

    if (!checkoutItemsContainer || !cartCount || !orderTotalElement || !deliveryFeeElement || !grandTotalElement || !cartDataInput || !checkoutForm) {
        console.error('One or more DOM elements are missing.');
        return;
    }

    let orderTotal = 0;
    const deliveryFee = 5.00; // Example delivery fee

    // Clear current items in the container
    checkoutItemsContainer.innerHTML = '';

    // Loop through the cart items and dynamically display them
    Object.keys(cart).forEach(seedId => {
        const item = cart[seedId];

        // Check if item data is valid
        if (!item || !item.name || !item.price || !item.quantity || !item.image) {
            console.error('Invalid item data:', item);
            return;
        }

        // Convert price to number and handle invalid values
        const price = parseFloat(item.price);
        const quantity = parseInt(item.quantity, 10);
        
        if (isNaN(price) || isNaN(quantity)) {
            console.error('Invalid price or quantity for item:', item);
            return;
        }

        // Calculate total price for each item
        const itemTotalPrice = quantity * price;

        // Create HTML for each item with image as background
        const itemHtml = `
            <div class="col-12 mb-3 border-bottom border-1 item-row">
                <div class="row align-items-center item-container-checkout" style="background-image: url('${item.image}'); background-size: cover; background-position: center; height: 100px;">
                    
                    <div class="col-md-4 checkout-item-details">
                        <h5 class="checkout-name mb-1">${item.name}</h5>
                        <p class="checkout-price mb-1">$${price.toFixed(2)}</p>
                    </div>
                   
                    <div class=" checkout-cart-item-quantity">
                        <p class="mb-1">Quantity: ${quantity}</p>
                        <p class="mb-1 bg-success">Total: $${itemTotalPrice.toFixed(2)}</p>
                    </div>
                </div>
            </div>
        `;

        // Insert the item HTML into the container
        checkoutItemsContainer.insertAdjacentHTML('beforeend', itemHtml);

        // Update order total
        orderTotal += itemTotalPrice;
    });

    // Update cart count, order total, and grand total
    cartCount.textContent = Object.keys(cart).length;
    orderTotalElement.textContent = `$${orderTotal.toFixed(2)}`;
    deliveryFeeElement.textContent = `$${deliveryFee.toFixed(2)}`;
    grandTotalElement.textContent = `$${(orderTotal + deliveryFee).toFixed(2)}`;

    // Attach the cart data to the form before submission
    checkoutForm.addEventListener('submit', function (e) {
        e.preventDefault();
        cartDataInput.value = JSON.stringify(cart);
        this.submit(); // Proceed with form submission
    });
});
