from django.http import JsonResponse
from django.shortcuts import get_object_or_404, redirect, render
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from seeds.models import Seed
from .models import Cart, CartItem
from checkout.forms import OrderForm
from django.utils.html import format_html, mark_safe
from django.db import transaction
import logging
from django.views.decorators.http import require_POST

logger = logging.getLogger(__name__)

@require_POST
def add_to_cart(request, seed_id):
    """ Add a quantity of the specified seed to the cart """

    with transaction.atomic():
        # Get the seed and lock the row to prevent race conditions
        seed = get_object_or_404(Seed.objects.select_for_update(), id=seed_id)
        cart = get_or_create_cart(request)
        
        # Get or create the cart item
        cart_item, created = CartItem.objects.get_or_create(cart=cart, seed=seed)
        
        # Determine the quantity to add from the POST data
        quantity = int(request.POST.get('quantity', 1))  # Default to 1 if not provided

        # Debugging outputs
        logger.debug(f"Seed ID: {seed_id}")
        logger.debug(f"Requested quantity: {quantity}")
        logger.debug(f"Current stock available: {seed.in_stock}")
        logger.debug(f"Current quantity in cart: {cart_item.quantity}")

        while quantity > 0 and seed.in_stock > 0:
            # Calculate the quantity to add, respecting the stock
            add_quantity = min(quantity, seed.in_stock)
            
            # Update the cart item quantity
            if created:
                cart_item.quantity = add_quantity  # Set the initial quantity for a new item
            else:
                cart_item.quantity += add_quantity  # Increment the quantity for an existing item
            
            # Deduct the added quantity from stock
            seed.in_stock -= add_quantity
            seed.save()
            
            # Save the updated cart item
            cart_item.save()
            
            # Notify the user
            messages.success(request, f'Added {add_quantity} of {seed.name} to your cart.')
            logger.debug(f"Added {add_quantity} of {seed.name} to cart. Stock now: {seed.in_stock}")

            # If stock reaches zero
            if seed.in_stock == 0:
                messages.info(request, f'{seed.name} is now out of stock.')
                logger.debug(f'{seed.name} is now out of stock.')

            # Reduce the remaining quantity to add
            quantity -= add_quantity

            # Check if there is any quantity left to add
            if quantity > 0:
                # Re-fetch the seed and cart item to ensure data is up-to-date
                seed.refresh_from_db()
                cart_item = CartItem.objects.get(cart=cart, seed=seed)

    return redirect('seed_list')  # Adjust URL name as needed

def get_or_create_cart(request):
    """ Retrieve or create a cart for the user/session """
    if request.user.is_authenticated:
        return Cart.objects.get_or_create(user=request.user)[0]
    else:
        session_key = request.session.session_key
        if not session_key:
            request.session.create()  # Create a new session if none exists
            session_key = request.session.session_key
        return Cart.objects.get_or_create(session_id=session_key)[0]

def remove_from_cart(request, seed_id):
    seed = get_object_or_404(Seed, id=seed_id)
    cart = get_or_create_cart(request)
    
    try:
        cart_item = CartItem.objects.get(cart=cart, seed=seed)
        # Add the quantity back to stock
        seed.in_stock += cart_item.quantity
        seed.save()
        cart_item.delete()
        messages.success(request, f'{seed.name} removed from your cart.')
    except CartItem.DoesNotExist:
        messages.error(request, f'{seed.name} was not found in your cart.')
    
    return redirect('cart_detail')


@require_POST
def update_cart_item(request, seed_id):
    """ Update the quantity of the specified seed in the cart """

    with transaction.atomic():
        # Get the seed and lock the row to prevent race conditions
        seed = get_object_or_404(Seed.objects.select_for_update(), id=seed_id)
        cart = get_or_create_cart(request)
        
        # Get the cart item
        cart_item = get_object_or_404(CartItem, cart=cart, seed=seed)
        
        # Get the quantity from POST data
        quantity_str = request.POST.get('quantity', '')
        logger.debug(f"Quantity string from POST: '{quantity_str}'")

        # Convert the quantity to an integer
        try:
            new_quantity = int(quantity_str)
        except ValueError:
            new_quantity = 1  # Default to 1 if conversion fails
        
        # Debugging outputs
        logger.debug(f"Seed ID: {seed_id}")
        logger.debug(f"Requested new quantity: {new_quantity}")
        logger.debug(f"Current stock available: {seed.in_stock}")
        logger.debug(f"Current quantity in cart: {cart_item.quantity}")

        if new_quantity <= 0:
            # If the new quantity is 0 or less, remove the item from the cart
            seed.in_stock += cart_item.quantity  # Restock the quantity back
            seed.save()
            cart_item.delete()
            messages.success(request, f'Removed {seed.name} from your cart.')
            logger.debug(f"Removed {seed.name} from the cart. Stock replenished: {seed.in_stock}")
        else:
            # Calculate the stock difference
            quantity_difference = new_quantity - cart_item.quantity
            logger.debug(f"Quantity difference: {quantity_difference}")

            if quantity_difference > 0:
                # Check if there's enough stock for the increase
                if quantity_difference > seed.in_stock:
                    messages.error(request, f'Sorry, only {seed.in_stock} more of {seed.name} available in stock.')
                    logger.debug(f"Insufficient stock to increase quantity of {seed.name} to {new_quantity}.")
                else:
                    # Adjust stock accordingly
                    seed.in_stock -= quantity_difference
                    seed.save()

                    # Update the cart item quantity
                    cart_item.quantity = new_quantity
                    cart_item.save()

                    messages.success(request, f'Updated {seed.name} quantity to {new_quantity}.')
                    logger.debug(f"Updated quantity of {seed.name} in cart to {new_quantity}. Stock now: {seed.in_stock}")

                    # Notify if stock reaches zero
                    if seed.in_stock == 0:
                        messages.error(request, f'{seed.name} is now out of stock.')
                        logger.debug(f'{seed.name} is now out of stock.')

            elif quantity_difference < 0:
                # If decreasing the quantity
                # Increase stock by the quantity we are removing from the cart
                seed.in_stock -= quantity_difference  # quantity_difference is negative here, so this effectively increases stock
                seed.save()

                # Update the cart item quantity
                cart_item.quantity = new_quantity
                cart_item.save()

                messages.success(request, f'Updated {seed.name} quantity to {new_quantity}.')
                logger.debug(f"Updated quantity of {seed.name} in cart to {new_quantity}. Stock now: {seed.in_stock}")

    return redirect('cart_detail')

def cart_detail(request):
    cart = get_or_create_cart(request)
    cart_items = CartItem.objects.filter(cart=cart).select_related('seed')

    for item in cart_items:
        logger.debug(f"Cart item ID: {item.id}, Quantity: {item.quantity}")

    form = OrderForm()

    context = {
        'cart': cart,
        'form': form,
        'total': cart.get_total_price(),
        'delivery': cart.get_delivery_cost(),
        'grand_total': cart.get_grand_total(),
        'cart_items': cart_items,  # Pass cart_items to the template
    }

    return render(request, 'cart/cart.html', context)




def get_or_create_cart(request):
    if request.user.is_authenticated:
        return Cart.objects.get_or_create(user=request.user)[0]
    else:
        session_id = request.session.session_key
        if not session_id:
            request.session.create()
            session_id = request.session.session_key
        return Cart.objects.get_or_create(session_id=session_id)[0]


def update_checkout_cart_item(request, seed_id):
    seed = get_object_or_404(Seed, id=seed_id)
    cart = get_or_create_cart(request)
    
    try:
        cart_item = CartItem.objects.get(cart=cart, seed=seed)
        if 'quantity' in request.POST:
            new_quantity = int(request.POST['quantity'])
            
            if new_quantity > seed.in_stock + cart_item.quantity:
                messages.error(request, f'Sorry, only {seed.in_stock} of {seed.name} are available.')
            elif new_quantity > 0:
                # Adjust the stock based on the new quantity
                stock_difference = new_quantity - cart_item.quantity
                seed.in_stock -= stock_difference
                seed.save()

                cart_item.quantity = new_quantity
                cart_item.save()
                messages.success(request, f'Updated quantity of {seed.name} to {new_quantity}.')
            else:
                # If the new quantity is 0 or less, remove the item and return stock
                seed.in_stock += cart_item.quantity
                seed.save()
                cart_item.delete()
                messages.warning(request, f'{seed.name} removed from your cart.')
    except CartItem.DoesNotExist:
        messages.error(request, f'{seed.name} was not found in your cart.')

    return redirect('checkout')
