from django.conf import settings
from django.http import HttpResponse
from django.views.decorators.http import require_POST
from django.views.decorators.csrf import csrf_exempt
from checkout.webhook_handler import StripeWH_Handler
import stripe

"""
This view handles incoming webhook notifications from Stripe. Webhooks allow Stripe 
to notify the server about events related to payments, such as successful payments, 
failed payments, etc. 

In this implementation, we use Stripe's Webhook API to verify the event's authenticity 
using a signature key and then delegate the event handling to a custom handler class.

- `wh_secret` holds the secret key used to verify Stripe’s event signatures.
- The `event_map` is a dictionary mapping Stripe event types to custom handler methods.
- Each event type, such as 'payment_intent.succeeded', is mapped to a corresponding 
  handler function, which processes the event accordingly.
"""

@require_POST
@csrf_exempt
def webhook(request):
    """
    Handles POST requests from Stripe webhooks. 

    Steps:
        1. Validates the signature to ensure the webhook is sent by Stripe.
        2. Constructs the event object from the request payload.
        3. Retrieves and calls the appropriate handler based on the event type.
        4. Returns an appropriate HTTP response indicating the outcome of handling the event.

    Parameters:
        request (HttpRequest): The incoming HTTP request object containing the payload and signature.
        
    Returns:
        HttpResponse: A response indicating the success or failure of processing the webhook.
    """
    
    # Setup
    wh_secret = settings.STRIPE_WH_SECRET
    stripe.api_key = settings.STRIPE_SECRET_KEY

    # Get the webhook data and verify its signature
    payload = request.body
    sig_header = request.META['HTTP_STRIPE_SIGNATURE']
    event = None

    try:
        event = stripe.Webhook.construct_event(
        payload, sig_header, wh_secret
        )
    except ValueError as e:
        # Invalid payload
        return HttpResponse(status=400)
    except stripe.error.SignatureVerificationError as e:
        # Invalid signature
        return HttpResponse(status=400)
    except Exception as e:
        return HttpResponse(content=e, status=400)

    # Set up a webhook handler
    handler = StripeWH_Handler(request)

    # Map webhook events to relevant handler functions
    event_map = {
        'payment_intent.succeeded': handler.handle_payment_intent_succeeded,
        'payment_intent.payment_failed': handler.handle_payment_intent_payment_failed,
    }

    # Get the webhook type from Stripe
    event_type = event['type']

    # If there's a handler for it, get it from the event map
    # Use the generic one by default
    event_handler = event_map.get(event_type, handler.handle_event)

    # Call the event handler with the event
    response = event_handler(event)
    return response
