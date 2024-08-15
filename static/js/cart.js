document.addEventListener('DOMContentLoaded', function() {
    const navigationContainer = document.querySelector('.navigation-container');

    // Toggle the position of the navigation container when it is clicked
    navigationContainer.addEventListener('click', function() {
        if (navigationContainer.classList.contains('centered')) {
            navigationContainer.classList.remove('centered');
            navigationContainer.style.top = '60px';
            navigationContainer.style.right = '40px';
            navigationContainer.style.left = 'auto';
            navigationContainer.style.transform = 'none';
            navigationContainer.style.width = '100px';
            navigationContainer.style.height = '100px';
        } else {
            navigationContainer.classList.add('centered');
            navigationContainer.style.top = '50%';
            navigationContainer.style.left = '50%';
            navigationContainer.style.transform = 'translate(-50%, -50%)';
            navigationContainer.style.right = 'auto';
            navigationContainer.style.width = '300px';
            navigationContainer.style.height = '300px';
        }
    });

    // Handle removing items from the cart
    document.querySelectorAll('.remove-form').forEach(function(form) {
        form.addEventListener('submit', function(event) {
            event.preventDefault();

            var url = this.action;

            fetch(url, {
                method: 'POST',
                headers: {
                    'X-CSRFToken': '{{ csrf_token }}',
                    'Accept': 'application/json',
                    'X-Requested-With': 'XMLHttpRequest'
                },
            })
            .then(response => response.json())
            .then(data => {
                if (data.cart_total !== undefined) {
                    // Update the cart total on the page
                    document.querySelector('.cart-total').textContent = data.cart_total;

                    if (data.item_removed) {
                        // Remove the item from the DOM
                        this.closest('tr.cart-item').remove();

                        // If the cart is empty after removing the item, show the empty cart message
                        if (!document.querySelector('.cart-item')) {
                            document.querySelector('.cart-container').innerHTML = `
                                <div class="empty-cart-message">
                                    <h3>Your cart is currently empty.</h3>
                                    <a href="{% url 'cart_detail' %}" class="btn btn-shop">Start Shopping</a>
                                </div>`;
                        }
                    }
                }
            });
        });
    });

    document.addEventListener('DOMContentLoaded', function() {
        // Handle updating item quantities in the cart
        document.querySelectorAll('.update-form').forEach(function(form) {
            form.addEventListener('submit', function(event) {
                event.preventDefault();
    
                var url = this.action;
    
                fetch(url, {
                    method: 'POST',
                    headers: {
                        'X-CSRFToken': '{{ csrf_token }}',
                        'Accept': 'application/json',
                        'X-Requested-With': 'XMLHttpRequest'
                    },
                    body: new FormData(this)
                })
                .then(response => response.json())
                .then(data => {
                    if (data.cart_total !== undefined) {
                        // Update the cart total on the page
                        document.querySelector('.cart-total').textContent = data.cart_total;
    
                        let itemRow = this.closest('tr.cart-item');
    
                        if (data.item_removed) {
                            // Remove the item from the DOM if it was removed
                            itemRow.remove();
    
                            if (!document.querySelector('.cart-item')) {
                                document.querySelector('.cart-container').innerHTML = `
                                    <div class="empty-cart-message">
                                        <h3>Your cart is currently empty.</h3>
                                        <a href="{% url 'cart_detail' %}" class="btn btn-shop">Start Shopping</a>
                                    </div>`;
                            }
                        } else {
                            // Update the total for the item if it wasn't removed
                            itemRow.querySelector('.cart-item-total').textContent = data.item_total;
                        }
    
                        // Redirect to the same page
                        window.location.href = window.location.href;
                    }
                })
                .catch(error => console.error('Error updating cart item:', error));
            });
        });
    });
    
});
