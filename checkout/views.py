import stripe
import logging
from django.conf import settings

from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from .models import Order, OrderLineItem
from .forms import OrderForm
from seeds.models import Seed
from custom_accounts.models import UserProfile
from cart.models import Cart, CartItem
from django.urls import reverse
from django.http import JsonResponse

from cart.context_processors import cart_context
# Set up Stripe with secret key
stripe.api_key = settings.STRIPE_SECRET_KEY



# Configure logging
logger = logging.getLogger(__name__)

def checkout(request):
    stripe_public_key = settings.STRIPE_PUBLIC_KEY
    stripe_secret_key = settings.STRIPE_SECRET_KEY

    logger.debug("Starting checkout process.")

    cart_data = cart_context(request)
    cart = cart_data.get('cart')

    if not cart or not cart.items.exists():
        logger.warning("Cart is empty, redirecting to products page.")
        messages.error(request, "There's nothing in your cart at the moment.")
        return redirect('https://8000-nlekkerman-futureflower-v9397r1bhgn.ws.codeinstitute-ide.net/seeds/?show_seeds=true')
    order_form_data = request.session.get('order_form_data', {})
    order_form = OrderForm(initial=order_form_data)

    total = cart_data.get('total', 0)
    stripe_total = round(total * 100)  # Stripe expects the amount in cents
    stripe.api_key = stripe_secret_key

    if 'payment_intent_id' not in request.session:
        try:
            intent = stripe.PaymentIntent.create(
                amount=stripe_total,
                currency=settings.STRIPE_CURRENCY,
                payment_method_types=['card'],
            )
            request.session['payment_intent_id'] = intent.id
            logger.info("PaymentIntent created successfully: %s", intent.id)
        except Exception as e:
            logger.error("Failed to create PaymentIntent: %s", str(e))
            messages.error(request, 'There was an issue processing your payment. Please try again.')
            return redirect('checkout')
    else:
        intent_id = request.session['payment_intent_id']
        intent = stripe.PaymentIntent.retrieve(intent_id)

    if request.method == 'POST':
        order_form = OrderForm(request.POST)

        if order_form.is_valid():
            request.session['order_form_data'] = request.POST
            
            try:
                payment_intent = stripe.PaymentIntent.retrieve(intent_id)

                # Check if the payment has already been processed
                if payment_intent.status == 'succeeded':
                    logger.info("Payment has already been processed for %s", request.POST['email'])
                    messages.success(request, "Your payment was already successful!")
                    return redirect('cart')  # Redirect if payment is already succeeded

                # Process the payment
                if payment_intent.status == 'requires_confirmation':
                    # Confirm the payment if it requires confirmation
                    stripe.PaymentIntent.confirm(intent_id)

                # Check again after confirmation
                payment_intent = stripe.PaymentIntent.retrieve(intent_id)

                if payment_intent.status == 'succeeded':
                    logger.info("Payment has been successfully processed for %s", request.POST['email'])

                    # Clear session data
                    del request.session['order_form_data']
                    del request.session['payment_intent_id']

                    messages.success(request, "Your payment was successful!")
                    return redirect('cart')
                else:
                    logger.warning("Payment intent status is not succeeded: %s", payment_intent.status)
                    messages.error(request, 'Payment was not successful.')
                    return redirect('checkout')

            except Exception as e:
                logger.error("Failed to process payment: %s", str(e))
                messages.error(request, 'There was an error processing your payment.')
                return redirect('checkout')

        else:
            # If the order form is invalid, store the errors in session
            request.session['order_form_errors'] = order_form.errors.as_json()
            logger.error("Order form is invalid: %s", order_form.errors)
            messages.error(request, 'There were errors in the form. Please correct them and try again.')
            return redirect('checkout')

    template = 'checkout/checkout.html'
    context = {
        'order_form': order_form,
        'stripe_public_key': stripe_public_key,
        'client_secret': intent.client_secret,
        'cart': cart,
        'total': total,
    }

    return render(request, template, context)


def get_or_create_cart(request):
    if request.user.is_authenticated:
        return Cart.objects.get_or_create(user=request.user)[0]
    else:
        session_id = request.session.session_key
        if not session_id:
            request.session.create()  # Create a session if one does not exist
            session_id = request.session.session_key
        return Cart.objects.get_or_create(session_id=session_id)[0]



def order_success(request, order_number):
    order = get_object_or_404(Order, order_number=order_number)
    return render(request, 'checkout/order_success.html', {'order': order})
