document.addEventListener('DOMContentLoaded', function () {
    const searchForm = document.getElementById('search-form');
    const searchInput = document.getElementById('searchInput');

    console.log('Search form:', searchForm);
    console.log('Search input:', searchInput);

    searchForm.addEventListener('submit', function (event) {
        const queryValue = searchInput.value;
        console.log('Search query:', queryValue); // Debugging line

        if (!queryValue) {
            event.preventDefault(); // Prevent form submission if value is not set correctly
            alert('Search input is empty!');
        }
    });
});

document.addEventListener('DOMContentLoaded', function () {
    // Handle close button clicks
    const closeButtons = document.querySelectorAll('.close-button-container');
    closeButtons.forEach(function (button) {
        button.addEventListener('click', function () {
            const message = this.closest('.message-container');
            if (message) {
                message.style.display = 'none'; // Hide the message
            }
        });
    });


});

document.addEventListener('DOMContentLoaded', (event) => {
    var chatIcon = document.getElementById('chatIcon');
    if (chatIcon) {
        chatIcon.addEventListener('click', function(event) {
            console.log('Chat icon clicked');
            // Uncomment below line to log href attribute
            // console.log('Redirecting to:', chatIcon.href);
        });
    }
});


document.addEventListener('DOMContentLoaded', function () {
    // Handle filtering and sorting without page reload (optional)
    document.querySelectorAll('.filter-buttons a, .sorting-buttons a').forEach(button => {
        button.addEventListener('click', function (e) {
            e.preventDefault();
            window.location.href = this.href;
        });
    });
});



document.addEventListener('DOMContentLoaded', function() {
    // Get references to the button and filter container
    const toggleButton = document.getElementById('filter-toggle');
    const filterContainer = document.getElementById('filter-container');
    const filterIcon = document.getElementById('filter-icon');

    // Function to toggle the visibility of the filter container
    function toggleFilterVisibility() {
        if (filterContainer.classList.contains('d-none')) {
            filterContainer.classList.remove('d-none'); // Show the filter container
            filterIcon.classList.remove('fa-filter');
            filterIcon.classList.add('fa-times'); // Change icon to a close icon
        } else {
            filterContainer.classList.add('d-none'); // Hide the filter container
            filterIcon.classList.remove('fa-times');
            filterIcon.classList.add('fa-filter'); // Change icon back to filter icon
        }
    }

    // Add event listener to the button
    toggleButton.addEventListener('click', toggleFilterVisibility);
});

// Handle the cart button click
document.addEventListener('DOMContentLoaded', () => {
    console.log('DOM fully loaded and parsed');

    const viewCartButton = document.getElementById('cart-button');
    if (viewCartButton) {
        console.log('Cart button found:', viewCartButton);

        viewCartButton.addEventListener('click', (event) => {
            console.log('Cart button clicked');
            event.preventDefault(); // Prevent default link behavior

            // Check if cart data exists in localStorage
            const cartData = localStorage.getItem('cart_data');
            if (cartData) {
                console.log('Cart data found in localStorage. Redirecting to cart page...');
                window.location.href = '/cart/'; // Navigate to the cart page
            } else {
                console.warn('No cart data found in localStorage. Displaying empty cart message.');
                
                // Navigate to the cart page
                window.location.href = '/cart/'; // Navigate to the cart page
            }
        });
    } else {
        console.warn('Cart button not found in the DOM');
    }
});