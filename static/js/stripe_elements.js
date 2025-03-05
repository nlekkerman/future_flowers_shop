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

const style = {
  base: {
    color: "#000", // Text color
    fontSize: "16px",
    fontFamily: "Arial, sans-serif",
    "::placeholder": {
      color: "#aaa" // Placeholder color
    },
    backgroundColor: "white", // Background color
    
    
  },
  invalid: {
    color: "#ff0000", // Red text for invalid inputs
    iconColor: "#ff0000"
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
        // Retrieve the PaymentIntent before confirming payment
        stripe.retrievePaymentIntent(clientSecret).then(function (result) {
            if (result.error) {
                console.error('Error retrieving payment intent:', result.error.message);
                alert(`Error retrieving payment intent: ${result.error.message}`);
                $('#card-errors').html(`<span class="checkout-icon" role="alert"><i class="fas fa-times"></i></span><span>${result.error.message}</span>`);
                card.update({'disabled': false});
                $('#submit-button').attr('disabled', false);
                
                return;
            }

            if (result.paymentIntent.status === 'succeeded') {
                // If payment is already successful, skip confirmation and submit the form
                console.log('PaymentIntent has already been confirmed and succeeded.');
                form.submit();
                clearCart();
                closeModal();
                showModal("You're almost there! 🌱 Thank you for choosing us for your gardening journey. In just a moment, you’ll be nurturing your seeds and watching them blossom into vibrant plants. Prepare for the joy of cultivating life in your garden!");
                return; // Skip the rest of the process if the payment is already successful
            }

            // If PaymentIntent has not succeeded, continue with the payment confirmation process
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
                    card.update({'disabled': false});
                    $('#submit-button').attr('disabled', false);
                    closeModal();
                } else if (result.paymentIntent.status === 'succeeded') {
                    // Successful payment
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
                    alert(`Unhandled payment status: ${result.paymentIntent.status}`);
                    closeModal();
                }
            }).catch(function (error) {
                console.error('Unexpected error:', error);
                alert(`Unexpected error: ${error.message}`);
            });
        }).catch(function (error) {
            console.error('Error retrieving payment intent:', error);
            alert(`Error retrieving payment intent: ${error.message}`);
        });
    }).fail(function () {
        console.error('Failed to cache checkout data.');
        alert('Failed to cache checkout data. Please try again.');
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
    // Modal HTML structure with a dynamic message and animation container using Bootstrap
    // Remove any existing modal and animation before creating a new one
    $('#thankYouModal').remove();  // Remove any previously opened modal
    $('#modalOverlay').remove();   // Remove any previous overlay
    const modalHTML = `
        <div id="thankYouModal" class="modal d-block d-flex justify-content-center" tabindex="-1" role="dialog" aria-labelledby="thankYouModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content dark-rgba-background">
                    <div class="modal-header">
                        <h5 class="modal-title" id="thankYouModalLabel">Thank You for Shopping with Us!</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body  dark-rgba-background">
                        <div id="animationContainer" style="width: 100%; height: 300px;"></div>
                        <p>${message}</p>
                    </div>
                    <div class="modal-footer">
                        <button id="closeModalButton" class="btn btn-primary">Close</button>
                    </div>
                </div>
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

    // Make sure the modal remains visible
    $('#thankYouModal').modal('show');  // This is an explicit command to show the modal.

    // Close modal on button click
    $('#closeModalButton').on('click', function() {
        closeModal();
    });
}

function closeModal() {
    $('#thankYouModal').fadeOut(function() {
        $(this).remove(); // Remove the modal from the DOM after fading out
    });
    $('#modalOverlay').fadeOut(function() {
        $(this).remove(); // Remove overlay after fade out
    });
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