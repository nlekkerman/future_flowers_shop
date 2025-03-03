"""
This module provides API endpoints and view functions for managing a shopping cart. It includes endpoints 
to add items to a cart, update item quantities, delete items, and render the cart view template.
The module supports both authenticated user sessions and guest sessions, using session IDs to manage 
carts for unauthenticated users. Errors are logged to assist with debugging in case of invalid data 
or unexpected behavior.
"""
from django.shortcuts import render, redirect, get_object_or_404
from .models import Cart, CartItem
from seeds.models import Seed
from django.contrib.auth.decorators import login_required
from django.contrib import messages

def get_cart(request):
    """Retrieve or create a cart for the user or session."""
    try:
        if request.user.is_authenticated:
            # Try to get or create a cart for the authenticated user
            cart, created = Cart.objects.get_or_create(user=request.user)
        else:
            # Get or create a cart based on the session id for unauthenticated users
            session_id = request.session.session_key
            if not session_id:
                request.session.create()  # Create a session if none exists
                session_id = request.session.session_key
            cart, created = Cart.objects.get_or_create(session_id=session_id)
        
        return cart

    except Exception as e:
        # If something goes wrong, log the error and provide a message
        messages.error(request, "There was an issue with retrieving your cart. Please try again later.")
        print(f"Error retrieving or creating cart: {e}")
        return None


def cart_view(request):
    cart = get_cart(request)  # Retrieve the cart (session-based or database)
    cart_items = cart.items.all()  # Fetch all items in the cart
    total_price = cart.get_total_price()  # Total before discounts
    total_discount = cart.get_total_discount()  # Total discount applied
    grand_total = cart.get_grand_total()  # Final total after discount
    total_items = sum(item.quantity for item in cart_items)
    total_unique_items = cart.items.count()

    context = {
        "cart": cart,
        "cart_items": cart_items,
        "total_price": total_price,
        "total_discount": total_discount,
        "grand_total": grand_total,
        "total_items": total_items,
        "total_unique_items": total_unique_items,
    }
    
    return render(request, "cart/cart.html", context)

def add_to_cart(request, seed_id):
    """Add a seed to the cart or increase its quantity."""
    try:
        cart = get_cart(request)
        seed = get_object_or_404(Seed, id=seed_id)

        cart_item, created = CartItem.objects.get_or_create(cart=cart, seed=seed)
        if not created:
            cart_item.quantity += 1
            cart_item.save()
            messages.success(request, f"{seed.name} quantity increased in your cart.")
        else:
            # If it's a new item in the cart
            messages.success(request, f"{seed.name} added to your cart.")

    except Seed.DoesNotExist:
        messages.error(request, "The seed you are trying to add does not exist.")
    except Exception as e:
        messages.error(request, "Something went wrong. Please try again later.")
        # Log the error for debugging purposes
        print(f"Error adding item to cart: {e}")

    return redirect('cart:cart')

def remove_from_cart(request, item_id):
    """Remove an item from the cart."""
    try:
        cart_item = get_object_or_404(CartItem, id=item_id)
        cart_item.delete()
        messages.success(request, f"Successfully deleted {cart_item.seed.name} from your cart.")
    
    except CartItem.DoesNotExist:
        # In case the CartItem is not found (although get_object_or_404 should handle this)
        messages.error(request, "The item you are trying to delete does not exist.")
    
    except Exception as e:
        # Catch any unexpected errors
        messages.error(request, "Can't remove the item now, please try again later.")
        # Log the error for debugging (optional)
        print(f"Error removing item from cart: {e}")

    return redirect('cart:cart')

def update_cart(request, item_id):
    """Update the quantity of an item in the cart."""
    try:
        cart_item = get_object_or_404(CartItem, id=item_id)
        new_quantity = request.POST.get('quantity')

        # Check if the quantity is a valid positive integer
        if new_quantity and int(new_quantity) > 0:
            cart_item.quantity = int(new_quantity)
            cart_item.save()
            messages.success(request, f"Quantity updated in your cart to {cart_item.quantity}.")
        else:
            messages.error(request, "Please enter a valid quantity greater than zero.")

    except Exception as e:
        # Catch any unexpected errors
        messages.error(request, "Can't update now, please try again later.")
        # Log the error for debugging (optional)
        print(f"Error updating cart: {e}")

    return redirect('cart:cart')


def clear_cart(request):
    """Clear all items from the cart."""
    try:
        # Get the user's cart
        cart = get_cart(request)
        
        # Attempt to delete all items from the cart
        cart.items.all().delete()
        messages.success(request, "Your cart has been cleared.")

    except Exception as e:
        # Catch any unexpected errors and provide a generic error message
        messages.error(request, "There was an issue clearing your cart. Please try again later.")
        print(f"Error while clearing cart: {e}")
    
    return redirect('cart:cart')

