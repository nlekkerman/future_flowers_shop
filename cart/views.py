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
from django.core.paginator import Paginator


def get_cart(request):
    """
    Retrieves or creates a cart based on authentication status: 
    - If the user is logged in, it fetches or creates a cart linked to the user. 
    - If the user is not logged in, it fetches or creates a cart using a session ID. 
    - If no session exists, it creates one before assigning the cart. 
    - Returns the cart object if successful; otherwise, logs an error and returns None.
    """
    
    try:
        if request.user.is_authenticated:
            cart, created = Cart.objects.get_or_create(user=request.user)
        else:
            session_id = request.session.session_key
            if not session_id:
                request.session.create()
                session_id = request.session.session_key
            cart, created = Cart.objects.get_or_create(session_id=session_id)
        
        return cart

    except Exception as e:
        messages.error(request, "There was an issue with retrieving your cart. Please try again later.")
        return None


def cart_view(request):
    """
    Handles displaying the user's cart: 
    - Retrieves the cart and its items.
    - Paginates items, showing 3 per page.
    - Calculates total price, discount, grand total, and item counts.
    - Updates available stock for each item.
    - Passes all relevant data to the cart template for rendering.
    """
    cart = get_cart(request)
    cart_items = cart.items.all()
    paginator = Paginator(cart_items, 3)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number) 
    total_price = cart.get_total_price()
    total_discount = cart.get_total_discount() 
    grand_total = cart.get_grand_total()
    total_items = sum(item.quantity for item in cart_items)
    total_unique_items = cart.items.count()
    
    
    for item in cart_items:
        item.total_available_stock = item.seed.in_stock_number + item.quantity


    context = {
        "cart": cart,
        "cart_items": page_obj,
        "total_price": total_price,
        "total_discount": total_discount,
        "grand_total": grand_total,
        "total_items": total_items,
        "total_unique_items": total_unique_items,
    }
    
    
    return render(request, "cart/cart.html", context)


def add_to_cart(request, seed_id):
    """
    Adds a seed to the user's cart:
    - Retrieves the cart and the seed.
    - Validates the requested quantity against available stock.
    - Updates the seed stock accordingly.
    - Adds the seed to the cart or updates the quantity if already present.
    - Displays success or error messages based on the action outcome.
    - Redirects the user back to the cart page.
    """
    
    try:
        cart = get_cart(request)
        seed = get_object_or_404(Seed, id=seed_id)
        quantity_to_add = int(request.POST.get('quantity', 1))

        if quantity_to_add < 1 or quantity_to_add > seed.in_stock_number:
            messages.error(request, f"Sorry, we only have {seed.in_stock_number} of {seed.name} in stock.")
            return redirect('cart:cart')

        seed.in_stock_number -= quantity_to_add
        if seed.in_stock_number == 0:
            seed.is_in_stock = False
        seed.save()

        cart_item, created = CartItem.objects.get_or_create(cart=cart, seed=seed)

        if not created:
            cart_item.quantity += quantity_to_add
            cart_item.save()
            messages.success(request, f"{seed.name} quantity increased in your cart.")
        else:
            cart_item.quantity = quantity_to_add
            cart_item.save()
            messages.success(request, f"{seed.name} added to your cart.")

    except Seed.DoesNotExist:
        messages.error(request, "The seed you are trying to add does not exist.")
    except Exception as e:
        messages.error(request, "Something went wrong. Please try again later.")
        print(f"Error adding item to cart: {e}")

    return redirect('cart:cart')


def remove_from_cart(request, item_id):
    """
    Removes an item from the cart:
    - Retrieves the cart item and associated seed.
    - Restores the stock quantity when the item is removed.
    - Updates the seed's stock status.
    - Deletes the cart item.
    - Provides feedback messages for success or errors.
    - Redirects back to the cart page.
    """
    try:
        cart_item = get_object_or_404(CartItem, id=item_id)
        seed = cart_item.seed
        seed.in_stock_number += cart_item.quantity
        
        
        if seed.in_stock_number > 0:
            seed.is_in_stock = True
        else:
            seed.is_in_stock = False


        seed.save()
        cart_item.delete()
        messages.success(request, f"Successfully deleted {cart_item.seed.name} from your cart.")
    
    
    except CartItem.DoesNotExist:
        messages.error(request, "The item you are trying to delete does not exist.")
    
    
    except Exception as e:
        messages.error(request, "Can't remove the item now, please try again later.")


    return redirect('cart:cart')


def update_cart(request, item_id):
    """
    Updates the quantity of an item in the cart:
    - Retrieves the cart item and its associated seed.
    - Validates the new quantity input.
    - Ensures the new quantity does not exceed available stock.
    - Adjusts the seed stock accordingly.
    - Updates the cart item quantity.
    - Provides feedback messages for success or errors.
    - Redirects back to the cart page.
    """
    try:
        cart_item = get_object_or_404(CartItem, id=item_id)
        seed = cart_item.seed
        new_quantity = request.POST.get('quantity')

        if new_quantity and int(new_quantity) > 0:
            new_quantity = int(new_quantity)
            old_quantity = cart_item.quantity
            total_available_stock = seed.in_stock_number + old_quantity


            if new_quantity > total_available_stock:
                messages.error(request, f"Not enough stock. You can only have {total_available_stock} items.")
                return redirect('cart:cart')


            seed.in_stock_number -= (new_quantity - old_quantity)


            if seed.in_stock_number <= 0:
                seed.is_in_stock = False
                seed.in_stock_number = 0 
            else:
                seed.is_in_stock = True


            cart_item.quantity = new_quantity
            cart_item.save()
            seed.save()


            messages.success(request, f"Quantity updated in your cart to {cart_item.quantity}.")
        
        
        else:
            messages.error(request, "Please enter a valid quantity greater than zero.")

    except Exception as e:
        messages.error(request, "Can't update now, please try again later.")


    return redirect('cart:cart')


def clear_cart(request):
    """
    Clears all items from the cart:
    - Retrieves the user's cart.
    - Restores stock quantities for all items in the cart.
    - Updates the stock status of each seed.
    - Deletes all cart items.
    - Provides feedback messages for success or errors.
    - Redirects back to the cart page.
    """
    
    try:
        cart = get_cart(request)


        for cart_item in cart.items.all():
            seed = cart_item.seed
            seed.in_stock_number += cart_item.quantity
            if seed.in_stock_number > 0:
                seed.is_in_stock = True
            seed.save()
            
            
        cart.items.all().delete()
        messages.success(request, "Your cart has been cleared.")

    except Exception as e:
        messages.error(request, "There was an issue clearing your cart. Please try again later.")

    
    return redirect('cart:cart')


