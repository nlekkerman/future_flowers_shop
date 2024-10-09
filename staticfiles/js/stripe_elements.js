// Core logic/payment flow for this comes from here:
// https://stripe.com/docs/payments/accept-a-payment

// CSS from here: 
// https://stripe.com/docs/stripe-js

// Wait for the DOM to be fully loaded
document.addEventListener('DOMContentLoaded', function() {
    // Retrieve public key and client secret from the DOM
    var stripe_public_key = $('#id_stripe_public_key').text().slice(1, -1);
    var client_secret = $('#id_client_secret').text().slice(1, -1);

    // Log the retrieved keys for debugging
    console.log("Retrieved Stripe Public Key:", stripe_public_key); // Avoid logging in production
    console.log("Retrieved Client Secret:", client_secret); // Avoid logging in production

    // Initialize Stripe and elements
    var stripe = Stripe(stripe_public_key);
    console.log("Stripe initialized."); // Log that Stripe has been initialized

    var elements = stripe.elements();
    var style = {
        base: {
            color: 'white', // Normal text color
            fontFamily: '"Helvetica Neue", Helvetica, sans-serif',
            fontSmoothing: 'antialiased',
            fontSize: '16px',
            '::placeholder': {
                color: '#aab7c4' // Placeholder color when the field is not focused
            },
            ':-webkit-autofill': { // Autofill styles (for Chrome, Safari, etc.)
                color: '#000',  // Text color on autofill
                backgroundColor: '#fafafa' // Background color on autofill
            }
        },
        invalid: {
            color: 'blue', // Error text color
            iconColor: '#dc3545' // Error icon color
        },
        focus: {
            color: '#000', // Text color when focused
            '::placeholder': {
                color: '#777' // Placeholder color on focus
            }
        }
    };
    

    // Create the card element and mount it to the DOM
    var card = elements.create('card', {style: style});
    card.mount('#card-element');
    console.log("Card element mounted to the DOM."); // Log that the card element has been mounted

    // Handle realtime validation errors on the card element
    card.addEventListener('change', function (event) {
        var errorDiv = document.getElementById('card-errors');
        if (event.error) {
            var html = `
                <span class="icon" role="alert">
                    <i class="fas fa-times"></i>
                </span>
                <span>${event.error.message}</span>
            `;
            $(errorDiv).html(html);
        } else {
            errorDiv.textContent = '';
        }
    });

    // Handle form submit
    var form = document.getElementById('checkout-form');

    if (form) {
        console.log("Form element found. Attaching submit event listener.");

        form.addEventListener('submit', function(ev) {
            // Prevent default form submission
            ev.preventDefault();
            console.log("Form submission attempted.");

            // Disable the card element and the submit button
            card.update({ 'disabled': true });
            $('#submit-cart-button').attr('disabled', true);
            console.log("Card element and submit button disabled.");

            // Confirm card payment with Stripe
            stripe.confirmCardPayment(client_secret, {
                payment_method: {
                    card: card,
                }
            }).then(function(result) {
                // Check for errors in the payment confirmation
                if (result.error) {
                    console.error("Payment confirmation error:", result.error.message);
                    var errorDiv = document.getElementById('card-errors');
                    var html = `
                        <span class="icon" role="alert">
                        <i class="fas fa-times"></i>
                        </span>
                        <span>${result.error.message}</span>`;
                    $(errorDiv).html(html);
                    card.update({ 'disabled': false });
                    $('#submit-cart-button').attr('disabled', false);
                    console.log("Card element and submit button re-enabled due to error.");
                } else {
                    // Log the payment intent status
                    console.log("Payment Intent status:", result.paymentIntent.status);
                    if (result.paymentIntent.status === 'succeeded') {
                        console.log("Payment succeeded. Submitting the form.");
                        form.submit(); // Submit the form if payment succeeded
                    } else {
                        console.log("Payment not succeeded. Status:", result.paymentIntent.status);
                    }
                }
            }).catch(function(error) {
                // Handle any unexpected errors
                console.error("Unexpected error during payment confirmation:", error);
            });
        });
    } else {
        console.error("Form element not found. Please check the HTML.");
    }
});
