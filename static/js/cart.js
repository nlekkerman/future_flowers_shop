document.addEventListener('DOMContentLoaded', function() {
    const searchInput = document.getElementById('searchInput');
    const searchButton = document.getElementById('searchButton');

    // Clear input field on page load
    searchInput.value = '';

    // Toggle button visibility on input click
    searchInput.addEventListener('focus', function() {
        searchButton.style.display = 'block';
        searchInput.placeholder = "Search seeds..."; // Show placeholder on focus
    });

    searchInput.addEventListener('blur', function() {
        if (searchInput.value === '') {
            searchButton.style.display = 'none';
            searchInput.placeholder = ''; // Hide placeholder on blur
        }
    });

    // Clear input field when search button is clicked
    searchButton.addEventListener('click', function() {
        searchInput.value = '';
    });
});

$(document).ready(function() {
    // Debounce function to limit the rate of AJAX requests
    function debounce(func, wait) {
        let timeout;
        return function(...args) {
            clearTimeout(timeout);
            timeout = setTimeout(() => func.apply(this, args), wait);
        };
    }

    // Event handler for input changes in quantity fields
    $('input[name="quantity"]').on('input', debounce(function() {
        var input = $(this);
        var form = input.closest('form');
        
        // Ensure the form has an ID and extract the seed ID
        var formId = form.attr('id');
        if (!formId) {
            console.error('Form ID is missing or undefined');
            return;
        }
        
        // Extract seed ID from the form ID (assuming form ID is in the format 'cart-item-<seed_id>')
        var seedId = formId.split('-').pop(); 
        if (!seedId) {
            console.error('Seed ID could not be extracted from form ID');
            return;
        }
        
        var quantity = parseInt(input.val(), 10);
        console.log(`Input changed for seed ID: ${seedId}. New quantity: ${quantity}`);
        
        // Fetch the max quantity from the server using the correct seed ID in the URL
        $.ajax({
            url: `/cart/max_quantity/${seedId}/`,  // Adjust the URL to match your pattern
            method: 'GET',
            success: function(data) {
                var maxQuantity = data.max_quantity;
                console.log(`Max quantity received for seed ID: ${seedId} is ${maxQuantity}`);
                
                // If the quantity exceeds the max quantity, update the input value
                if (quantity > maxQuantity) {
                    input.val(maxQuantity);
                    console.log(`Quantity adjusted to max allowed value: ${maxQuantity}`);
                }

                // Set the max attribute to prevent users from inputting a value higher than allowed
                input.attr('max', maxQuantity);
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error(`Failed to fetch max quantity: ${textStatus}, ${errorThrown}`);
            }
        });
    }, 300)); // Debounce delay of 300ms to reduce the number of AJAX requests
});



document.addEventListener('DOMContentLoaded', function() {
    // Event delegation for handling button clicks
    document.querySelectorAll('.add-to-cart-form').forEach(form => {
        form.addEventListener('submit', function(event) {
            event.preventDefault(); // Prevent form submission for demo purposes

            // Find the seed card to animate
            const seedCard = document.getElementById(`seed-card-${this.dataset.seedId}`);
            if (seedCard) {
                // Trigger the animation
                seedCard.classList.add('animate-shake-enlarge');

                // Submit the form after animation
                setTimeout(() => {
                    this.submit();
                }, 1000); // Delay to allow animation to finish
            }
        });
    });
});
