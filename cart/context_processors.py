from decimal import Decimal
from django.conf import settings
from django.shortcuts import get_object_or_404
from cart.models import Cart, CartItem
from seeds.models import Seed  # Import Seed model from seeds app

def cart_context(request):
    cart = None
    bag_items = []
    total = 0
    product_count = 0

    # Handle authenticated users
    if request.user.is_authenticated:
        try:
            cart = Cart.objects.get(user=request.user)
        except Cart.DoesNotExist:
            cart = None  # Optionally handle missing cart scenario

    # Handle anonymous users
    else:
        session_key = request.session.session_key
        if not session_key:
            request.session.create()  # Create a new session if none exists
            session_key = request.session.session_key
        try:
            cart = Cart.objects.get(session_id=session_key)
        except Cart.DoesNotExist:
            cart = None  # Optionally handle missing cart scenario

    # Process cart contents if it exists
    if cart:
        cart_items = CartItem.objects.filter(cart=cart)  # Query related items
        for cart_item in cart_items:
            seed = cart_item.seed
            quantity = cart_item.quantity
            total += cart_item.get_total_price()
            product_count += quantity
            bag_items.append({
                'item_id': seed.id,
                'quantity': quantity,
                'seed': seed,
                'total_price': cart_item.get_total_price(),
            })

        if total < settings.FREE_DELIVERY_THRESHOLD:
            delivery = total * Decimal(settings.STANDARD_DELIVERY_PERCENTAGE / 100)
            free_delivery_delta = settings.FREE_DELIVERY_THRESHOLD - total
        else:
            delivery = 0
            free_delivery_delta = 0
        
        grand_total = delivery + total

        context = {
            'cart': cart,
            'bag_items': bag_items,
            'total': total,
            'product_count': product_count,
            'delivery': delivery,
            'free_delivery_delta': free_delivery_delta,
            'free_delivery_threshold': settings.FREE_DELIVERY_THRESHOLD,
            'grand_total': grand_total,
        }
    else:
        context = {'cart': cart}

    return context
