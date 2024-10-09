# views.py
from django.http import JsonResponse
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import Cart, CartItem
from seeds.models import Seed
from decimal import Decimal
from django.shortcuts import render, get_object_or_404, redirect
from django.views.decorators.csrf import csrf_exempt
import logging
import json
from django.views.decorators.http import require_POST
from django.contrib.auth.decorators import login_required

def cart_view(request):
    
    return render(request, 'cart/cart.html')


logger = logging.getLogger(__name__)

@csrf_exempt
@require_POST
def add_to_cart(request):
    try:
        logger.info("Received request to add item to cart")

        # Parse the request data
        data = json.loads(request.body)
        seed_id = data.get('seed_id')
        quantity = int(data.get('quantity', 1))

        # Validate input
        if not seed_id or quantity <= 0:
            logger.error(f"Invalid input: seed_id={seed_id}, quantity={quantity}")
            return HttpResponseBadRequest("Invalid input")

        # Get or create the cart for the user
        if request.user.is_authenticated:
            cart, created = Cart.objects.get_or_create(user=request.user)
            logger.info(f"Cart {'created' if created else 'retrieved'} for user: {request.user.username}")
        else:
            # Create a cart for anonymous users using session ID or other unique identifier
            session_key = request.session.session_key
            if not session_key:
                request.session.save()  # Ensure a session is created
                session_key = request.session.session_key
            
            cart, created = Cart.objects.get_or_create(session_id=session_key)
            logger.info(f"Cart {'created' if created else 'retrieved'} for anonymous user: {session_key}")

        # Get the seed object
        try:
            seed = Seed.objects.get(id=seed_id)
        except Seed.DoesNotExist:
            logger.error(f"Seed with ID {seed_id} not found")
            return JsonResponse({'error': 'Seed not found'}, status=404)

        # Get or create the cart item
        cart_item, created = CartItem.objects.get_or_create(
            cart=cart, seed=seed, defaults={'quantity': quantity}
        )

        if not created:
            # Update the quantity of the existing cart item
            cart_item.quantity += quantity
            cart_item.save()
            logger.info(f"Updated quantity of seed ID {seed_id} in cart to {cart_item.quantity}")

        # Prepare the response data
        cart_data = {
            'id': cart.id,
            'total_price': float(cart.get_total_price()),
            'total_discount': float(cart.get_total_discount()),
            'delivery_cost': float(cart.get_delivery_cost()),
            'grand_total': float(cart.get_grand_total()),
            'items': []
        }

        # Add cart items to the response
        for item in cart.items.all():
            item_price = item.seed.price  # This is likely already a Decimal
            item_discount = Decimal(item.seed.discount or 0)
            discounted_price = item_price - (item_price * (item_discount / Decimal(100)))

            item_data = {
                'id': item.id,
                'seed': {
                    'id': item.seed.id,
                    'name': item.seed.name,
                    'price': float(discounted_price),
                    'is_in_stock': item.seed.is_in_stock
                },
                'quantity': item.quantity,
                'total_price': float(item.get_total_price())
            }
            cart_data['items'].append(item_data)

        return JsonResponse(cart_data, status=200)

    except Exception as e:
        logger.error(f"An error occurred: {str(e)}")
        return JsonResponse({'error': str(e)}, status=500)


@csrf_exempt
def update_quantity(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            cart_id = data.get('cart_id')
            seed_id = data.get('seed_id')
            new_quantity = data.get('quantity')

            if not all([cart_id, seed_id, new_quantity]):
                return JsonResponse({'error': 'Missing parameters'}, status=400)

            cart = get_object_or_404(Cart, id=cart_id)
            cart_item, created = CartItem.objects.get_or_create(cart=cart, seed_id=seed_id)
            cart_item.quantity = new_quantity
            cart_item.save()

            return JsonResponse({'success': True, 'new_quantity': cart_item.quantity})
        except json.JSONDecodeError:
            return JsonResponse({'error': 'Invalid JSON'}, status=400)
    return JsonResponse({'error': 'Only POST method allowed'}, status=405)


@csrf_exempt
@require_POST
@login_required
def delete_item(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            cart_id = data.get('cart_id')
            seed_id = data.get('seed_id')

            if not cart_id or not seed_id:
                return JsonResponse({'error': 'Missing parameters'}, status=400)

            cart = get_object_or_404(Cart, id=cart_id)
            cart_item = CartItem.objects.filter(cart=cart, seed_id=seed_id).first()

            if not cart_item:
                return JsonResponse({'error': 'Item not found in cart'}, status=404)

            cart_item.delete()

            return JsonResponse({'success': True}, status=200)
        except json.JSONDecodeError:
            return JsonResponse({'error': 'Invalid JSON'}, status=400)
    return JsonResponse({'error': 'Only POST method allowed'}, status=405)


