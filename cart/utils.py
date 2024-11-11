from django.contrib.auth.decorators import login_required
from .models import Cart

import logging

logger = logging.getLogger(__name__)

def get_max_possible_quantity(in_stock, current_quantity):
    """
    Calculate the maximum possible quantity that can be set for a cart item.
    """
    max_quantity = in_stock + current_quantity
    return max_quantity


@login_required
def get_or_create_cart(request):
    """
    Retrieves or creates a shopping cart for the authenticated user.

    This function ensures that every authenticated user has a unique, active cart. If a cart already exists 
    for the user (and it has not been marked as deleted), it retrieves that cart. Otherwise, it creates a new 
    cart instance associated with the user. This function uses Django’s `get_or_create` method for efficient 
    querying and creation if necessary.

    Decorators:
        @login_required: Ensures that the user is authenticated before accessing or creating a cart. 
                         Redirects unauthenticated users to the login page.

    Parameters:
        - request (HttpRequest): The HTTP request object, which includes the authenticated user information.

    Returns:
        Cart: The existing or newly created Cart instance associated with the authenticated user.
    """
    user = request.user
    cart, created = Cart.objects.get_or_create(user=user, deleted=False)
    return cart
