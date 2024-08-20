from django.shortcuts import get_object_or_404, redirect, render
from django.contrib import messages
from seeds.models import Seed
from .models import Cart, CartItem

from django.utils.html import format_html, mark_safe

def add_to_cart(request, seed_id):
    seed = get_object_or_404(Seed, id=seed_id)
    cart = get_or_create_cart(request)
    
    cart_item, created = CartItem.objects.get_or_create(cart=cart, seed=seed)
    
    if not created:
        cart_item.quantity += 1
        cart_item.save()
        message_content = format_html(
            '<strong>{}</strong> quantity updated to {}. Price: ${}', 
            seed.name, 
            cart_item.quantity,  # Show the updated quantity
            f"{seed.price:.2f}"
        )
    else:
        message_content = format_html(
            '<strong>{}</strong> added to your cart with quantity {}. Price: ${}', 
            seed.name, 
            cart_item.quantity,  # Initial quantity, which is 1 when added
            f"{seed.price:.2f}"
        )
    
    if seed.image:
        message = format_html(
            '<div class="message-content">'
            '<img src="{}" style="width: 50px; height: auto; margin-right: 10px;" alt="{}" />'
            '{}'
            '</div>',
            seed.image.url, seed.name, message_content
        )
    else:
        message = message_content
    
    messages.success(request, mark_safe(message))
    
    return redirect('seed_list')  # Or any other page you want to redirect to
def get_or_create_cart(request):
    if request.user.is_authenticated:
        return Cart.objects.get_or_create(user=request.user)[0]
    else:
        session_id = request.session.session_key
        if not session_id:
            request.session.create()  # Create a session if one does not exist
            session_id = request.session.session_key
        return Cart.objects.get_or_create(session_id=session_id)[0]


def remove_from_cart(request, seed_id):
    seed = get_object_or_404(Seed, id=seed_id)
    cart = get_or_create_cart(request)
    
    try:
        cart_item = CartItem.objects.get(cart=cart, seed=seed)
        cart_item.delete()
        messages.success(request, f'{seed.name} removed from your cart.')
    except CartItem.DoesNotExist:
        messages.error(request, f'{seed.name} was not found in your cart.')
    
    return redirect('cart_detail')

def update_cart_item(request, seed_id):
    seed = get_object_or_404(Seed, id=seed_id)
    cart = get_or_create_cart(request)
    
    try:
        cart_item = CartItem.objects.get(cart=cart, seed=seed)
        if 'quantity' in request.POST:
            quantity = int(request.POST['quantity'])
            if quantity > 0:
                cart_item.quantity = quantity
                cart_item.save()
                messages.success(request, f'Updated quantity of {seed.name} to {quantity}.')
            else:
                cart_item.delete()
                messages.warning(request, f'{seed.name} removed from your cart.')
    except CartItem.DoesNotExist:
        messages.error(request, f'{seed.name} was not found in your cart.')

    return redirect('cart_detail')

def cart_detail(request):
    cart = get_or_create_cart(request)
    return render(request, 'cart/cart.html', {'cart': cart})
