from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from .models import Order, OrderLineItem
from .forms import OrderForm
from seeds.models import Seed
from cart.models import Cart, CartItem  # Adjust the import path if necessary

def get_or_create_cart(request):
    if request.user.is_authenticated:
        return Cart.objects.get_or_create(user=request.user)[0]
    else:
        session_id = request.session.session_key
        if not session_id:
            request.session.create()  # Create a session if one does not exist
            session_id = request.session.session_key
        return Cart.objects.get_or_create(session_id=session_id)[0]

def checkout(request):
    cart = get_or_create_cart(request)
    if request.method == 'POST':
        form = OrderForm(request.POST)
        if form.is_valid():
            order = form.save(commit=False)
            if request.user.is_authenticated:
                order.user_profile = get_object_or_404(UserProfile, user=request.user)
            else:
                order.user_profile = None
            order.original_bag = str(cart)  # Save the cart information
            order.save()
            
            # Add line items for each item in the cart
            for item in cart.cartitem_set.all():
                seed = get_object_or_404(Seed, pk=item.seed.id)
                OrderLineItem.objects.create(
                    order=order,
                    seed=seed,
                    quantity=item.quantity,
                    lineitem_total=seed.calculate_discounted_price() * item.quantity
                )
            order.update_total()  # Update totals and save the order

            # Clear the cart after successful checkout
            request.session['cart'] = {'items': []}

            messages.success(request, f'Order {order.order_number} placed successfully!')
            return redirect('order_success', order_number=order.order_number)
        else:
            messages.error(request, 'Please correct the errors below.')
    else:
        form = OrderForm()

    return render(request, 'checkout/checkout.html', {'form': form, 'cart': cart})

def order_success(request, order_number):
    order = get_object_or_404(Order, order_number=order_number)
    return render(request, 'checkout/order_success.html', {'order': order})
