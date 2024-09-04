// Display Cart function in control.js
export function displayCart() {
    console.log('Display Cart function called');

    // Retrieve cart data from localStorage
    const cartData = JSON.parse(localStorage.getItem('cart_data'));
    const cartItems = cartData ? cartData.items : [];
    const cartItemsContainer = document.getElementById('cart-items-container');
    const totalPriceElement = document.querySelector('.text-primary');
    const totalDiscountElement = document.querySelector('.text-danger');

    if (!cartItemsContainer) {
        console.error('Element with ID "cart-items-container" not found.');
        return;
    }

    if (cartItems.length === 0) {
        console.log('Cart is empty');
        cartItemsContainer.innerHTML = `
            <div class="text-center">
                <h3>Your cart is currently empty.</h3>
                <a href="/seeds/" class="btn btn-primary btn-lg">Start Shopping</a>
            </div>
        `;
        if (totalPriceElement) totalPriceElement.textContent = '$0.00';
        if (totalDiscountElement) totalDiscountElement.textContent = '$0.00';
        return;
    }

    cartItemsContainer.innerHTML = ''; // Clear previous items
    let totalPrice = 0;
    let totalDiscount = 0;

    cartItems.forEach(item => {
        totalPrice += item.total_price;
        totalDiscount += item.discount || 0;

        // Construct image URL
        const imageSrc = item.image 
            ? `https://res.cloudinary.com/dg0ssec7u/image/upload/${item.image}.webp`
            : '/media/images/default-image.jpg';

        // Generate HTML for item
        const itemHTML = `
            <div class="border-bottom border-1 position-relative">
                <div class="align-items-center item-row row">
                    <a href="/seeds/${item.seed_id}" class="col-md-6">
                        <h5>${item.name}</h5>
                    </a>
                    <div class="col-md-2 text-center">
                        <div class="card-img-container">
                            <img src="${imageSrc}" class="card-img-top" alt="${item.name}" onerror="console.error('Image failed to load for item:', '${item.name}', '${imageSrc}')">
                            ${item.discount > 0 ? '<span class="discount-label">Discounted</span>' : ''}
                        </div>
                    </div>
                    <div class="col-md-2">
                        <h6>Price</h6>
                        <p>$${item.price.toFixed(2)}</p>
                    </div>
                    <div class="col-md-2">
                        <h6>In Stock</h6>
                        ${item.in_stock > 5 ? 
                            `<p class="card-text text-success"><strong>In stock:</strong> ${item.in_stock}</p>` :
                            item.in_stock > 0 ?
                            `<p class="card-text text-warning"><strong>Hurry! Only ${item.in_stock} left in stock!</strong></p>` :
                            `<p class="card-text text-danger"><strong>Out of Stock</strong></p>`
                        }
                    </div>
                    <div class="col-md-2">
                        <h6>Quantity</h6>
                        <form id="cart-item-${item.seed_id}" action="/update_cart_item/${item.seed_id}" method="post" class="d-inline">
                            <input type="number" name="quantity" value="${item.quantity}" min="0" max="${item.max_possible_quantity}" data-seed-id="${item.seed_id}" class="form-control form-control-sm w-75 d-inline" placeholder="Quantity">
                            <button type="submit" class="btn btn-sm mt-2">Update</button>
                        </form>
                    </div>
                    <div class="col-md-2 text-right">
                        <h6>Total</h6>
                        <p>$${item.total_price.toFixed(2)}</p>
                    </div>
                    <form action="/remove_from_cart/${item.seed_id}" method="post" class="remove-from-cart-form">
                        <button type="submit" class="remove-from-cart-button">
                            <i class="fas fa-trash"></i>
                        </button>
                    </form>
                </div>
            </div>
        `;
        cartItemsContainer.innerHTML += itemHTML;
    });

    if (totalPriceElement) totalPriceElement.textContent = `$${totalPrice.toFixed(2)}`;
    if (totalDiscountElement) totalDiscountElement.textContent = `$${totalDiscount.toFixed(2)}`;
    console.log('Cart displayed with total price:', totalPrice.toFixed(2), 'and total discount:', totalDiscount.toFixed(2));
}

document.addEventListener('DOMContentLoaded', function() {
    displayCart();
  });