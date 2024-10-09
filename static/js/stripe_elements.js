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
        color: '#000',
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

var card = elements.create('card', {style: style});
card.mount('#card-element');

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
    } else {
        errorDiv.textContent = '';
        console.log('Card validation success: No errors.');
    }
});

// Handle form submit
var form = document.getElementById('payment-form');

// Handle form submit
var form = document.getElementById('payment-form');

form.addEventListener('submit', function(ev) {
    ev.preventDefault();
    
    console.log('Form submitted. Preparing to confirm payment...');

    card.update({ 'disabled': true });
    $('#submit-cart-button').attr('disabled', true);

    // Log the payment method details being sent to Stripe
    console.log('Payment method details:', {
        card: card
    });

    // Log the client secret to confirm the correct secret is being used
    console.log('Client secret:', clientSecret);

    stripe.confirmCardPayment(clientSecret, {
        payment_method: {
            card: card,
        }
    }).then(function(result) {
        // Log the full result object for further inspection
        console.log('Payment confirmation response:', result);

        if (result.error) {
            var errorDiv = document.getElementById('card-errors');
            var html = `
                <span class="checkout-icon" role="alert">
                <i class="fas fa-times"></i>
                </span>
                <span>${result.error.message}</span>`;
            $(errorDiv).html(html);
            
            console.error('Payment confirmation error:', result.error.message);
            
            // Log the full error object for more details
            console.error('Full error object:', result.error);

            card.update({ 'disabled': false });
            $('#submit-cart-button').attr('disabled', false);
        } else {
            console.log('Payment confirmation result:', result);
            console.log('Payment intent status:', result.paymentIntent.status);

            if (result.paymentIntent.status === 'succeeded') {
                console.log('Payment successful! Submitting form now...');
                form.submit();
            } else {
                console.warn('Payment status is not succeeded:', result.paymentIntent.status);
                // Log the entire paymentIntent object for further diagnosis
                console.warn('PaymentIntent details:', result.paymentIntent);
            }
        }
    }).catch(function(error) {
        console.error('Error during payment confirmation:', error);

        // Log additional error details if available
        if (error && error.response) {
            console.error('Stripe API error response:', error.response);
        }
    });
});
