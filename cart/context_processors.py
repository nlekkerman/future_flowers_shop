from decimal import Decimal
from django.conf import settings
from django.shortcuts import get_object_or_404
from cart.models import Cart, CartItem
from seeds.models import Seed

def cart_context(request):
    """
    Generates and returns the context dictionary for the shopping cart, containing
    information such as total prices, item details, delivery charges, and any applicable 
    free delivery threshold calculations.

    Parameters:
        request (HttpRequest): The current request object, which is used to identify
                               if the user is authenticated and to access the session.

    Returns:
        dict: A dictionary containing cart information such as item details, subtotal,
              delivery charges, and grand total. If no cart is found, the context
              will contain an empty cart entry.
    """
    cart = None
    bag_items = []
    total = Decimal('0.00')
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
            request.session.create() 
            session_key = request.session.session_key
        cart = Cart.objects.filter(session_id=session_key, deleted=False).first()

    # Process cart contents if it exists
    if cart:
        cart_items = CartItem.objects.filter(cart=cart, deleted=False) 
        for cart_item in cart_items:
            seed = cart_item.seed
            quantity = cart_item.quantity
            item_total_price = cart_item.get_total_price()  
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
