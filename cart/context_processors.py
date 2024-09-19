from decimal import Decimal
from django.conf import settings
from django.shortcuts import get_object_or_404
from cart.models import Cart, CartItem
from seeds.models import Seed  # Import Seed model from seeds app

def cart_context(request):
    cart = None
    bag_items = []
    total = Decimal('0.00')  # Initialize total as Decimal
    product_count = 0
    delivery = Decimal('0.00')
    free_delivery_delta = Decimal('0.00')

    # Handle authenticated users
    if request.user.is_authenticated:
        cart = Cart.objects.filter(user=request.user, deleted=False).first()

    # Handle anonymous users
    else:
        session_key = request.session.session_key
        if not session_key:
            request.session.create()  # Create a new session if none exists
            session_key = request.session.session_key
        cart = Cart.objects.filter(session_id=session_key, deleted=False).first()

    # Process cart contents if it exists
    if cart:
        cart_items = CartItem.objects.filter(cart=cart, deleted=False)  # Query related items
        for cart_item in cart_items:
            seed = cart_item.seed
            quantity = cart_item.quantity
            item_total_price = cart_item.get_total_price()  # Use `get_total_price()` to calculate total
            total += item_total_price
            product_count += quantity
            bag_items.append({
                'item_id': seed.id,
                'quantity': quantity,
                'seed': seed,
                'total_price': item_total_price,
            })

        # Calculate delivery cost and free delivery threshold
        if total < Decimal(settings.FREE_DELIVERY_THRESHOLD):
            delivery_percentage = Decimal(settings.STANDARD_DELIVERY_PERCENTAGE) / Decimal('100')
            delivery = delivery_percentage * total
            free_delivery_delta = Decimal(settings.FREE_DELIVERY_THRESHOLD) - total
        else:
            delivery = Decimal('0.00')
            free_delivery_delta = Decimal('0.00')
        
        grand_total = delivery + total

        context = {
            'cart': cart,
            'bag_items': bag_items,
            'total': total,
            'product_count': product_count,
            'delivery': delivery,
            'free_delivery_delta': free_delivery_delta,
            'free_delivery_threshold': Decimal(settings.FREE_DELIVERY_THRESHOLD),
            'grand_total': grand_total,
        }
    else:
        context = {'cart': cart}

    return context
