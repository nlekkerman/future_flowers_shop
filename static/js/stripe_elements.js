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

    card.update({ 'disabled': true });
    $('#submit-cart-button').attr('disabled', true);

    stripe.confirmCardPayment(clientSecret, {
        payment_method: { card: card }
    }).then(function(result) {
        if (result.error) {
            console.error('Payment confirmation error:', result.error.message);
            $('#card-errors').html(`<span class="checkout-icon" role="alert"><i class="fas fa-times"></i></span><span>${result.error.message}</span>`);
            card.update({ 'disabled': false });
            $('#submit-cart-button').attr('disabled', false);
        } else if (result.paymentIntent.status === 'succeeded') {
            form.submit();
        } else if (result.paymentIntent.status === 'requires_action') {
            stripe.handleCardAction(result.paymentIntent.client_secret).then(function(result) {
                if (result.error) {
                    console.error('3D Secure authentication failed:', result.error.message);
                } else if (result.paymentIntent.status === 'succeeded') {
                    form.submit();
                }
            });
        } else {
            console.warn('Unhandled payment status:', result.paymentIntent.status);
        }
    }).catch(function(error) {
        console.error('Unexpected error:', error);
    });
});

