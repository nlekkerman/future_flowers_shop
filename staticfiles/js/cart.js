document.addEventListener('DOMContentLoaded', function() {
    const navigationContainer = document.querySelector('.navigation-container');

    // Toggle the position of the navigation container when it is clicked
    navigationContainer.addEventListener('click', function() {
        if (navigationContainer.classList.contains('centered')) {
            // If it's centered, remove the centered class and move it back to the top-right corner
            navigationContainer.classList.remove('centered');
            navigationContainer.style.top = '60px';
            navigationContainer.style.right = '40px';
            navigationContainer.style.left = 'auto'; // Reset left position
            navigationContainer.style.transform = 'none'; // Reset transform
            navigationContainer.style.width = '100px'; // Reset transform
            navigationContainer.style.height = '100px'; // Reset transform
        } else {
            // If it's not centered, add the centered class and move it to the center
            navigationContainer.classList.add('centered');
            navigationContainer.style.top = '50%';
            navigationContainer.style.left = '50%';
            navigationContainer.style.transform = 'translate(-50%, -50%)';
            navigationContainer.style.right = 'auto'; // Reset right position
            navigationContainer.style.width = '300px'; // Reset transform
            navigationContainer.style.height = '300px'; // Reset transform
        }
    });
});


document.querySelectorAll('.remove-form').forEach(function(form) {
    form.addEventListener('submit', function(event) {
        event.preventDefault(); // Prevent the default form submission

        // Get the form action URL
        var url = this.action;

        // Perform the AJAX request
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

                // Optionally, you can remove the item from the DOM
                this.closest('tr.cart-item').remove();

                // If the cart is empty after removing the item, show the empty cart message
                if (!document.querySelector('.cart-item')) {
                    document.querySelector('.cart-container').innerHTML = `
                        <div class="empty-cart-message">
                            <h3>Your cart is currently empty.</h3>
                            <a href="{% url 'cart' %}" class="btn btn-shop">Start Shopping</a>
                        </div>`;
                }
            }
        });
    });
});
