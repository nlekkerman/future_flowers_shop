import stripe
import logging
import json
from django.conf import settings
from django.views.decorators.http import require_POST
from django.shortcuts import render, redirect, get_object_or_404, HttpResponse
from django.core.mail import send_mail
from django.contrib import messages
from .models import Order, OrderLineItem
from .forms import OrderForm
from seeds.models import Seed
from custom_accounts.models import UserProfile
from cart.models import Cart, CartItem
from django.urls import reverse
from django.http import JsonResponse
from cart.context_processors import cart_context


# Configure logging

logger = logging.getLogger(__name__)

# Set up Stripe with secret key

stripe.api_key = settings.STRIPE_SECRET_KEY


@require_POST
def cache_checkout_data(request):
    """
    The `cache_checkout_data` function is used to store temporary
    checkout data related
    to the payment process. This function is invoked by the front-end
    to save cart information
    and other details to the PaymentIntent,
    so it can be accessed later when the payment is finalized.

    Steps:
        - Extract the client secret from the request
        and use it to retrieve the PaymentIntent ID.
        - Modify the PaymentIntent with metadata
        like cart details and user info.
        - Return an HTTP response to confirm that the data has been cached.
    """

    try:
        # Extract payment intent ID from client secret

        client_secret = request.POST.get("client_secret")
        logger.debug(f"Received client_secret: {client_secret}")

        # Extract payment intent ID

        pid = client_secret.split("_secret")[0]
        logger.debug(f"Extracted PaymentIntent ID: {pid}")

        # Retrieve cart data and other info from request

        cart = json.dumps(request.session.get("cart", {}))
        save_info = request.POST.get("save_info")
        username = request.user
        logger.debug(f"Cart data: {cart}")
        logger.debug(f"Save info: {save_info}, Username: {username}")

        # Modify the PaymentIntent in Stripe with metadata

        stripe.api_key = settings.STRIPE_SECRET_KEY
        logger.info(f"Modifying PaymentIntent with ID: {pid}")
        stripe.PaymentIntent.modify(
            pid,
            metadata={
                "cart": cart,
                "save_info": save_info,
                "username": str(username),
            },
        )
        logger.info(f"PaymentIntent {pid} modified successfully")
        return HttpResponse(status=200)
    except stripe.error.StripeError as e:
        # Catching Stripe-specific errors

        logger.error(f"StripeError occurred: {str(e)}", exc_info=True)
        messages.error(
            request,
            "Sorry, there was a problem with the payment processing."
            "Please try again later.",
        )
        return HttpResponse(content=str(e), status=400)
    except Exception as e:
        # General exception logging

        logger.error(
            f"An error occurred in cache_checkout_data: {str(e)}",
            exc_info=True,
        )
        messages.error(
            request,
            "Sorry, your payment cannot be processed right now."
            "Please try again later.",
        )
        return HttpResponse(content=str(e), status=400)


def checkout(request):
    """
    The `checkout` view function handles the entire checkou
    t process for the user.
    This process includes collecting form data
    (such as shipping details), validating
    the cart, creating an order, and integrating
    with Stripe to process the payment.

    Steps involved:
    1. Collect form data such as shipping
    information from the user.
    2. Validate the cart and ensure that it's not empty.
    3. Create an order and associate it with the user's
    cart and other relevant details.
    4. Integrate with Stripe to create or retrieve
    a PaymentIntent, which represents a payment session.
    5. Complete the payment processing by confirming
    the PaymentIntent and handling any necessary actions.
    6. On success, redirect the user to a success page
    with the order details; on failure, display error messages.
    """
    stripe_public_key = settings.STRIPE_PUBLIC_KEY
    stripe_secret_key = settings.STRIPE_SECRET_KEY

    if request.method == "POST":
        cart = request.session.get("cart", {})

        form_data = {
            "full_name": request.POST["full_name"],
            "email": request.POST["email"],
            "phone_number": request.POST["phone_number"],
            "country": request.POST["country"],
            "postcode": request.POST["postcode"],
            "town_or_city": request.POST["town_or_city"],
            "street_address1": request.POST["street_address1"],
            "street_address2": request.POST["street_address2"],
            "county": request.POST["county"],
        }
        order_form = OrderForm(form_data)
        if order_form.is_valid():
            order = order_form.save(commit=False)

            if request.user.is_authenticated:
                try:
                    profile = UserProfile.objects.get(user=request.user)
                    order.user_profile = profile
                except UserProfile.DoesNotExist:
                    logger.error(
                        "UserProfile does not exist for user: %s",
                        request.user.username,
                    )
                    messages.error(
                        request,
                        "An error occurred while processing your order.",
                    )
                    return redirect("checkout")
            client_secret = request.POST.get("client_secret")
            logger.debug(
                f"Received client_secret in HANDLER WAY: {client_secret}"
            )

            pid = client_secret.split("_secret")[0]
            logger.debug(f"Extracted PaymentIntent ID HANDLER WAY: {pid}")

            order.stripe_pid = pid
            order.original_bag = json.dumps(cart)
            order.save()
            logger.info(
                "Order form is valid. Order saved with ID: %s", order.id
            )

            cart = (
                Cart.objects.filter(user=request.user, deleted=False).first()
                if request.user.is_authenticated
                else Cart.objects.filter(
                    session_id=request.session.session_key, deleted=False
                ).first()
            )

            if cart:
                logger.info(
                    "Cart found for user: %s",
                    (
                        request.user.id
                        if request.user.is_authenticated
                        else request.session.session_key
                    ),
                )
                cart_items = cart.items.all()
                # Ensure cart.items() returns a dictionary

                for item in cart_items:
                    item_id = item.seed.id
                    quantity = item.quantity

                    try:
                        # Fetch the Seed instance

                        seed = Seed.objects.get(id=item_id)
                        logger.info(
                            "Processing item: %s with quantity: %s",
                            seed.name,
                            quantity,
                        )

                        # Create OrderLineItem for each item

                        order_line_item = OrderLineItem(
                            order=order,
                            seed=seed,  # Use seed instead of product
                            quantity=quantity,
                        )
                        order_line_item.save()
                        logger.info(
                            "Order line item saved: %s", order_line_item.id
                        )
                    except Seed.DoesNotExist:
                        logger.error(
                            "Seed with ID %s does not exist. Deleting order.",
                            item_id,
                        )
                        messages.error(
                            request,
                            (
                                "One of the seeds in your cart"
                                "wasn't found in our database. "
                                "Please call us for assistance!"
                            ),
                        )
                        order.delete()
                        return redirect(reverse("cart:cart"))
                # Clear the cart after processing the order

                request.session["save_info"] = "save-info" in request.POST
                logger.info(
                    "Redirecting to checkout success for order number: %s",
                    order.order_number,
                )

                return redirect(
                    reverse("checkout_success", args=[order.order_number])
                )
            else:
                logger.warning(
                    "Cart is empty for user: %s",
                    (
                        request.user.id
                        if request.user.is_authenticated
                        else request.session.session_key
                    ),
                )
                messages.error(request, "Your cart is empty.")
        else:
            logger.error(
                "Order form is invalid. Errors: %s", order_form.errors
            )
            messages.error(
                request,
                "There was an error with your form."
                "Please double-check your information.",
            )
        # If the cart is not valid

        cart = request.session.get("cart", {})
        if not cart:
            logger.warning(
                "There's nothing in the cart for user: %s",
                (
                    request.user.id
                    if request.user.is_authenticated
                    else request.session.session_key
                ),
            )
            messages.error(
                request, "There's nothing in your cart at the moment"
            )
            return redirect(reverse("cart:cart"))
        current_cart = cart_contents(request)
        total = current_cart["grand_total"]
        stripe_total = round(total * 100)
        stripe.api_key = stripe_secret_key
        intent = stripe.PaymentIntent.create(
            amount=stripe_total,
            currency=settings.STRIPE_CURRENCY,
        )

        order_form = OrderForm()
    logger.debug("Starting checkout process.")

    cart_data = cart_context(request)
    cart = cart_data.get("cart")

    if not cart or not cart.items.exists():
        logger.warning("Cart is empty, redirecting to products page.")
        messages.error(request, "There's nothing in your cart at the moment.")
        seeds_url = reverse("seeds") + "?show_seeds=true"
        return redirect(seeds_url)
    order_form_data = request.session.get("order_form_data", {})
    order_form = OrderForm(initial=order_form_data)

    total = cart_data.get("total", 0)
    stripe_total = round(total * 100)  # Stripe expects the amount in cents
    stripe.api_key = stripe_secret_key

    if "payment_intent_id" not in request.session:
        try:
            intent = stripe.PaymentIntent.create(
                amount=stripe_total,
                currency=settings.STRIPE_CURRENCY,
                payment_method_types=["card"],
            )
            request.session["payment_intent_id"] = intent.id
            logger.info("PaymentIntent created successfully: %s", intent.id)
        except Exception as e:
            logger.error("Failed to create PaymentIntent: %s", str(e))
            messages.error(
                request,
                "There was an issue processing your payment."
                "Please try again.",
            )
            return redirect("checkout")
    else:
        intent_id = request.session["payment_intent_id"]
        intent = stripe.PaymentIntent.retrieve(intent_id)
    if request.method == "POST":
        order_form = OrderForm(request.POST)

        if order_form.is_valid():
            request.session["order_form_data"] = request.POST

            try:
                payment_intent = stripe.PaymentIntent.retrieve(intent_id)
                logger.info("AT TOPE ID", intent_id)

                # Check if the payment has already been processed

                if payment_intent.status == "succeeded":
                    logger.info(
                        "Payment has already been processed for %s",
                        request.POST["email"],
                    )
                    messages.success(
                        request, "Your payment was already successful!"
                    )
                    return redirect(
                        "checkout_success"
                    )  # Redirect if payment is already succeeded

                if payment_intent.status == "requires_confirmation":
                    logger.info("Payment requires confirmation.")
                    # Confirm the payment if it requires confirmation

                    logger.info(
                        "Attempting to confirm PaymentIntent with ID: %s",
                        intent_id,
                    )

                    stripe.PaymentIntent.confirm(intent_id)

                elif payment_intent.status == "requires_action":
                    logger.warning(
                        "Payment requires additional action (e.g., 3D Secure)."
                    )
                    messages.warning(
                        request,
                        "Additional authentication is required."
                        " Please complete the process.",
                    )
                # Check again after confirmation

                payment_intent = stripe.PaymentIntent.retrieve(intent_id)

                if payment_intent.status == "succeeded":
                    logger.info(
                        "Payment has been successfully processed for %s",
                        request.POST["email"],
                    )

                    # Clear session data

                    del request.session["order_form_data"]
                    del request.session["payment_intent_id"]

                    messages.success(request, "Your payment was successful!")
                    return redirect("cart:cart")
                else:
                    logger.warning(
                        "Payment intent status is not succeeded: %s",
                        payment_intent.status,
                    )
                    messages.error(request, "Payment was not successful.")
                    return redirect("checkout")
            # Suggested: Stripe-specific error handling

            except stripe.error.StripeError as e:
                body = e.json_body
                err = body.get("error", {})
                logger.error("Stripe error: %s", err.get("message"))
                messages.error(
                    request,
                    f"There was an issue processing your payment:"
                    " {err.get('message')}",
                )
                return redirect("checkout")
        else:
            # If the order form is invalid, store the errors in session

            request.session["order_form_errors"] = order_form.errors.as_json()
            logger.error("Order form is invalid: %s", order_form.errors)
            messages.error(
                request,
                "There were errors in the form."
                " Please correct them and try again.",
            )
            return redirect("checkout")
    template = "checkout/checkout.html"
    context = {
        "order_form": order_form,
        "stripe_public_key": stripe_public_key,
        "client_secret": intent.client_secret,
        "cart": cart,
        "total": total,
    }

    return render(request, template, context)


def checkout_success(request, order_number):
    """
    Handle successful checkouts by displaying
    a success message, clearing session data,
    sending a confirmation email, and cleaning up any associated cart data.
    """
    save_info = request.session.get("save_info")
    order = get_object_or_404(Order, order_number=order_number)

    messages.success(
        request,
        f"Order successfully processed! \
        Your order number is {order_number}. A confirmation \
        email will be sent to {order.email}.",
    )

    user_id = request.user.id if request.user.is_authenticated else None

    if user_id:
        cart = Cart.objects.filter(user_id=user_id).first()

        if cart:
            cart.delete()
        else:
            logger.info(
                f"No cart found in database for user:"
                " {user_id} during checkout success"
                " for order number: {order_number}."
            )
    else:
        logger.warning("User not authenticated, cannot retrieve cart.")
    if "payment_intent_id" in request.session:
        del request.session["payment_intent_id"]
    if "save_info" in request.session:
        del request.session["save_info"]
    try:
        send_order_confirmation_email(order)
    except Exception as e:
        messages.warning(
            request,
            "Your order was successful,"
            " but we couldn't send the confirmation email."
            " Please contact support.",
        )
    template = "checkout/checkout_success.html"
    context = {
        "order": order,
    }

    return render(request, template, context)


def get_or_create_cart(request):
    """
    Retrieves an existing cart for the
    authenticated user or creates a new one if not found.
    If the user is not authenticated,
    a cart is created based on the session ID.
    """
    if request.user.is_authenticated:
        return Cart.objects.get_or_create(user=request.user)[0]
    else:
        session_id = request.session.session_key
        if not session_id:
            request.session.create()  # Create a session if one does not exist
            session_id = request.session.session_key
        return Cart.objects.get_or_create(session_id=session_id)[0]


def order_detail(request, order_number):
    """
    Display the details of a specific order using its order number.

    This view retrieves an order based on the provided `order_number`,
    and if found, renders a page that shows
    detailed information about the order,
    such as the items, quantities, prices, and total amount.

    Parameters:
    - `request`: The HTTP request object,
    which contains metadata about the request.
    - `order_number`: The unique identifier for the order,
    passed as part of the URL (URL parameter).

    Returns:
    - An HTTP response rendered using the 'checkout/order_detail.html'
    template with order details.
    """
    order = get_object_or_404(Order, order_number=order_number)
    context = {
        "order": order,
    }
    return render(request, "checkout/order_detail.html", context)


def send_order_confirmation_email(order):
    """
    Sends an order confirmation email to the user with order details.
    """

    subject = f"Order Confirmation - Order #{order.order_number}"
    email_from = settings.DEFAULT_FROM_EMAIL
    recipient_list = [order.email]

    try:
        logger.debug("Building email message content.")
        message = f"Hello {order.full_name},\n\n"
        message += "Thank you for your purchase from Future Flower Shop!\n\n"
        message += f"Order Number: {order.order_number}\n"
        message += f"Order Date: {order.date}\n\n"
        message += "Order Details:\n"

        order_items = order.lineitems.all()
        if order_items:
            for item in order_items:
                line_total = item.lineitem_total
                message += f"- {item.seed.name}"
                " (x{item.quantity}): ${line_total:.2f}\n"

        else:
            logger.warning(f"No items found for Order #{order.order_number}.")
        total_amount = order.grand_total
        message += f"\nTotal Amount: ${total_amount:.2f}\n\n"

        message += "We hope you have a wonderful time"
        "nurturing your seeds and watching them blossom"
        " into beautiful plants!\n"
        message += "If you have any questions or need assistance "
        "along the way, please don't hesitate to reach out to us.\n\n"

        logger.debug(
            f"Email content built successfully for"
            " Order #{order.order_number}."
        )
    except Exception as e:
        logger.error(
            f"Error while building email content for Order"
            " #{order.order_number}. Error: {e}"
        )
        return
    try:
        logger.info(f"Sending order confirmation email to {order.email}.")
        send_mail(
            subject, message, email_from, recipient_list, fail_silently=False
        )
        logger.info(
            f"Order confirmation email sent successfully to"
            "{order.email} for Order #{order.order_number}."
        )
    except Exception as e:
        logger.error(
            f"Failed to send order confirmation email to"
            " {order.email} for Order #{order.order_number}. Error: {e}"
        )
