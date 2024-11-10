/*
    Core logic/payment flow for this comes from here:
    https://stripe.com/docs/payments/accept-a-payment

    CSS from here: 
    https://stripe.com/docs/stripe-js
*/


var stripePublicKey = $('#id_stripe_public_key').text().slice(1, -1);
var clientSecret = $('#id_client_secret').text().slice(1, -1);
var stripe = Stripe(stripePublicKey);
var elements = stripe.elements();

var style = {
    base: {
        color: '#fff',
        fontFamily: '"Helvetica Neue", Helvetica, sans-serif',
        fontSmoothing: 'antialiased',
        fontSize: '16px',
        '::placeholder': {
            color: '#aab7c4'
        }
    },
    invalid: {
        color: '#dc3545',
        iconColor: '#dc3545'
    }
};

var card = elements.create('card', {
    style: style
});
card.mount('#card-element');

let cardValid = false; // Flag to track card validity

// Handle real-time validation errors on the card element
card.addEventListener('change', function (event) {
    var errorDiv = document.getElementById('card-errors');
    if (event.error) {
        var html = `
            <span class="checkout-icon" role="alert">
                <i class="fas fa-times"></i>
            </span>
            <span>${event.error.message}</span>
        `;
        $(errorDiv).html(html);
        console.error('Card validation error:', event.error.message);
        cardValid = false; // Mark card as invalid
    } else {
        errorDiv.textContent = '';
        cardValid = true; 
    }

    toggleSubmitButton(event.complete);
});

// Function to enable/disable the submit button based on card validity
function toggleSubmitButton(cardValid) {
    var submitButton = $('#submit-button');
    var messageDiv = $('#card-errors'); // Div to display messages

    if (cardValid) {
        submitButton.attr('disabled', false); // Enable the button if the card is valid
        messageDiv.text('Your card details are valid. You can proceed to checkout.')
                  .css('color', 'green')
                  .show(); 
        
    } else {
        submitButton.attr('disabled', true); // Disable the button if the card is invalid
        messageDiv.text('Please enter valid card details to enable the checkout button.')
                  .css('color', 'red')
                  .show();
                  
    }
}

// Call this function when the page loads to hide the message initially
$(document).ready(function() {
    $('#card-errors').hide(); // Hide the message div initially
});
// Handle form submit
var form = document.getElementById('payment-form');



form.addEventListener('submit', function (ev) {
    ev.preventDefault();

    // Disable the card input and submit button to prevent multiple submissions
    card.update({
        'disabled': true
    });
    $('#submit-button').attr('disabled', true);

    // Get the 'save info' checkbox status
    var saveInfo = Boolean($('#id-save-info').attr('checked'));
    // Get the CSRF token
    var csrfToken = $('input[name="csrfmiddlewaretoken"]').val();

    // Create post data to cache
    var postData = {
        'csrfmiddlewaretoken': csrfToken,
        'client_secret': clientSecret,
        'save_info': saveInfo,
    };
    var url = '/checkout/cache_checkout_data/';

    // Post data to cache checkout info
    $.post(url, postData).done(function () {
        // Confirm card payment with Stripe
        stripe.confirmCardPayment(clientSecret, {
            payment_method: {
                card: card,
                billing_details: {
                    name: $.trim(form.full_name.value),
                    phone: $.trim(form.phone_number.value),
                    email: $.trim(form.email.value),
                    address: {
                        line1: $.trim(form.street_address1.value),
                        line2: $.trim(form.street_address2.value),
                        city: $.trim(form.town_or_city.value),
                        country: $.trim(form.country.value),
                        state: $.trim(form.county.value),
                    }
                }
            },
            // Shipping details should be sent as part of the confirmCardPayment call, 
            // but outside the payment_method object
            shipping: {
                name: $.trim(form.full_name.value),
                phone: $.trim(form.phone_number.value),
                address: {
                    line1: $.trim(form.street_address1.value),
                    line2: $.trim(form.street_address2.value),
                    city: $.trim(form.town_or_city.value),
                    country: $.trim(form.country.value),
                    postal_code: $.trim(form.postcode.value),
                    state: $.trim(form.county.value),
                }
            }
        }).then(function (result) {
            if (result.error) {
                // Handle error in payment confirmation
                console.error('Payment confirmation error:', result.error.message);
                alert(`Payment error: ${result.error.message}`);
                $('#card-errors').html(`<span class="checkout-icon" role="alert"><i class="fas fa-times"></i></span><span>${result.error.message}</span>`);
                card.update({
                    'disabled': false
                });
                $('#submit-button').attr('disabled', false);
                closeModal();
            } else if (result.paymentIntent.status === 'succeeded') {
             
                form.submit();
                clearCart();
                closeModal();
                showModal("You're almost there! 🌱 Thank you for choosing us for your gardening journey. In just a moment, you’ll be nurturing your seeds and watching them blossom into vibrant plants. Prepare for the joy of cultivating life in your garden!");

            } else if (result.paymentIntent.status === 'requires_action') {
                // Handle 3D Secure authentication
                stripe.handleCardAction(result.paymentIntent.client_secret).then(function (result) {
                    if (result.error) {
                        console.error('3D Secure authentication failed:', result.error.message);
                        alert(`3D Secure authentication error: ${result.error.message}`); 
                        closeModal();
                    } else if (result.paymentIntent.status === 'succeeded') {
                        clearCart(); 
                       
                        form.submit();
                        closeModal();
                    }
                }).catch(function (error) {
                    console.error('Error during 3D Secure authentication:', error);
                    alert(`Error during 3D Secure authentication: ${error.message}`); 
                    closeModal();
                });
            } else {
                console.warn('Unhandled payment status:', result.paymentIntent.status);
                alert(`Unhandled payment status: ${result.paymentIntent.status}`); // Alert the user
                closeModal();
            }
        }).catch(function (error) {
            console.error('Unexpected error:', error);
            alert(`Unexpected error: ${error.message}`); // Alert the user
        });
    }).fail(function () {
        console.error('Failed to cache checkout data.');
        alert('Failed to cache checkout data. Please try again.'); // Alert the user
        location.reload();
    });
});



function clearCart() {
    const cartContents = localStorage.getItem('cart');
    if (cartContents) {
        console.log('Current cart contents before clearing:', cartContents);
    }
    localStorage.removeItem('cart'); // Adjust 'cart' to the actual key used for your cart
    console.log('Cart cleared from local storage.');
}

function showModal(message) {
    // Modal HTML structure with a dynamic message and animation container
    const modalHTML = `
        <div id="thankYouModal" class="modal" style="display: block;">
            <div class="modal-content">
                <h4>Thank You for Shopping with Us!</h4>
                <div id="animationContainer" style="width: 100%; height: 200px;"></div>
                <p>${message}</p>
            </div>
            <div class="modal-footer">
                <button id="closeModalButton" class="btn">Close</button>
            </div>
        </div>
        <div id="modalOverlay" class="modal-overlay"></div>
    `;

    // Append modal and overlay to body
    $('body').append(modalHTML);

    // Load and play the animation
    try {
        var animation = bodymovin.loadAnimation({
            container: document.getElementById('animationContainer'), // Required
            path: '/static/animations/truck-delivery-service.json', // Path to your animation file
            renderer: 'svg', // Render as SVG
            loop: true, // Loop the animation
            autoplay: true, // Autoplay the animation
        });
        console.log("Animation loaded successfully");
    } catch (error) {
        console.error("Error loading animation:", error);
    }

    // Close modal on button click
    $('#closeModalButton').on('click', closeModal);
}

// Function to close the modal
function closeModal() {
    $('#thankYouModal').remove(); // Remove modal
    $('#modalOverlay').remove();  // Remove overlay
}


// Add the click event to the submit button
document.getElementById('submit-button').onclick = function() {
    // Check if the form is filled and valid
    if (cardValid && form.checkValidity()) { 
        showModal("Your order is being processed! You will receive an email confirmation shortly.");

    } else {
        console.log("Form is invalid or card details are incorrect.");
        return; // Simply return if the form is not valid
    }
};