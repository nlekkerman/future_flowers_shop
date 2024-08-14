from django.shortcuts import get_object_or_404, redirect, render
from django.contrib.auth.decorators import login_required
from django.http import JsonResponse
from seeds.models import Seed
from .models import Cart, CartItem

@login_required
def add_to_cart(request, seed_id):
    seed = get_object_or_404(Seed, id=seed_id)
    cart, created = Cart.objects.get_or_create(user=request.user)
    cart_item, created = CartItem.objects.get_or_create(cart=cart, seed=seed)

    if not created:
        cart_item.quantity += 1
        cart_item.save()

    return redirect('cart_detail')

@login_required
def remove_from_cart(request, seed_id):
    seed = get_object_or_404(Seed, id=seed_id)
    cart = get_object_or_404(Cart, user=request.user)
    cart_item = get_object_or_404(CartItem, cart=cart, seed=seed)
    cart_item.delete()

    # Return updated cart total as JSON
    cart_total = cart.get_total_price()
    return JsonResponse({'cart_total': cart_total})

@login_required
def update_cart_item(request, seed_id):
    seed = get_object_or_404(Seed, id=seed_id)
    cart = get_object_or_404(Cart, user=request.user)
    cart_item = get_object_or_404(CartItem, cart=cart, seed=seed)

    if 'quantity' in request.POST:
        quantity = int(request.POST['quantity'])
        if quantity > 0:
            cart_item.quantity = quantity
            cart_item.save()
        else:
            cart_item.delete()

    # Return updated cart total as JSON
    cart_total = cart.get_total_price()
    return JsonResponse({'cart_total': cart_total})

@login_required
def cart_detail(request):
    cart, created = Cart.objects.get_or_create(user=request.user)
    return render(request, 'cart/cart.html', {'cart': cart})
