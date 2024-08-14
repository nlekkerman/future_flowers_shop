# cart/context_processors.py

from cart.models import Cart

def cart_context(request):
    cart = None
    if request.user.is_authenticated:
        try:
            cart = Cart.objects.get(user=request.user)
        except Cart.DoesNotExist:
            pass  # Handle missing cart scenario, if needed
    return {'cart': cart}
