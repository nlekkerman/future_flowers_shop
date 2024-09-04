document.addEventListener("DOMContentLoaded", function() {
    // Fetch cart data from localStorage
    let cart = JSON.parse(localStorage.getItem('cart')) || [];
    console.log('Cart fetched from localStorage:', cart);
    
    // Fetch seeds data from localStorage
    let seeds = JSON.parse(localStorage.getItem('seeds')) || [];
    console.log('Seeds fetched from localStorage:', seeds);

    // Function to find a seed by ID from the seeds data
    function getSeedById(seedId) {
        return seeds.find(seed => seed.id === seedId) || {};
    }

    // Function to render cart items
    function renderCartItems(cart) {
        const cartItemsContainer = document.getElementById('cart-items');
        const emptyCartMessage = document.getElementById('empty-cart-message');
        const cartSummary = document.getElementById('cart-summary');
        let total = 0;

        // Clear the container before adding items
        cartItemsContainer.innerHTML = '';

        if (cart.length === 0) {
            console.log('Cart is empty.');
            emptyCartMessage.style.display = 'block';
            cartSummary.style.display = 'none';
        } else {
            console.log('Cart has items.');
            emptyCartMessage.style.display = 'none';
            cartSummary.style.display = 'flex';

            cart.forEach(item => {
                const seed = getSeedById(item.id);

                // Check if item values are valid
                const price = seed.price ? parseFloat(seed.price) : 0;
                const quantity = item.quantity || 0;
                const itemTotal = (price * quantity) || 0;

                // Log item data for debugging
                console.log('Rendering item:', item);

                // Validate values before using them
                if (typeof price === 'number' && typeof quantity === 'number') {
                    total += itemTotal;

                    const itemElement = document.createElement('div');
                    itemElement.classList.add('col-12', 'mb-3', 'border-bottom', 'border-1', 'position-relative');

                    itemElement.innerHTML = `
                        <div class="align-items-center item-row">
                            <!-- Seed details with name above image -->
                            <a href="/seeds/${seed.id}">
                                <h5>${seed.name || 'Unknown'}</h5>
                            </a>
                            <div class="col-md-2 text-center">
                                ${seed.image_url ? `<img src="${seed.image_url}" alt="${seed.name}" class="cart-item-image" style="max-width: 150px;">` : `<img src="{% static 'images/default-image.jpg' %}" alt="Default Image" class="cart-item-image">`}
                            </div>
                            <!-- Price -->
                            <div class="col-md-2">
                                <h6>Price</h6>
                                <p>$${price.toFixed(2)}</p>
                            </div>
                            <!-- In Stock -->
                            <div class="col-md-2">
                                <p class="card-text ${seed.in_stock > 5 ? 'text-success' : (seed.in_stock > 0 && seed.in_stock <= 5 ? 'text-warning' : 'text-danger')}">
                                    <strong>In stock:</strong> ${seed.in_stock}
                                </p>
                            </div>
                            <!-- Quantity and Update Form -->
                            <div class="col-md-2">
                                <h6>Quantity</h6>
                                <form id="cart-item-${seed.id}" action="/update-cart-item/${seed.id}" method="post" class="d-inline">
                                    <input type="number" name="quantity" value="${quantity}" min="0" max="${item.max_possible_quantity}" class="form-control form-control-sm w-75 d-inline" placeholder="Quantity">
                                    <button type="submit" class="btn btn-sm mt-2">Update</button>
                                </form>
                            </div>
                            <!-- Total -->
                            <div class="col-md-2 text-right">
                                <h6>Total</h6>
                                <p>$${itemTotal.toFixed(2)}</p>
                            </div>
                            <!-- Font Awesome trash bin icon for removing item -->
                            <form action="/remove-from-cart/${seed.id}" method="post" class="remove-from-cart-form">
                                <button type="submit" class="remove-from-cart-button">
                                    <i class="fas fa-trash"></i> <!-- Font Awesome trash bin icon -->
                                </button>
                            </form>
                        </div>
                    `;
                    cartItemsContainer.appendChild(itemElement);
                } else {
                    console.error('Invalid item data:', item);
                }
            });

            // Assuming you have the logic for total and discount calculations in the template
            document.getElementById('cart-total').innerHTML = `<h4>Total: $${total.toFixed(2)}</h4>`;
            document.getElementById('cart-total-discount').innerHTML = `<h4>Discount: $${(total * 0.1).toFixed(2)}</h4>`; // Example discount calculation
        }
    }

    // Render the cart items on page load
    renderCartItems(cart);
});
