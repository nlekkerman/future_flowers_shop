# syncmanager/views.py

from django.http import JsonResponse, HttpResponseBadRequest
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_http_methods, require_POST
from django.utils.dateparse import parse_datetime
from django.utils.timezone import make_aware, is_naive
from django.contrib.auth.decorators import login_required
import logging
from seeds.models import Seed
from cart.models import Cart, CartItem
logger = logging.getLogger(__name__)
import json
from django.db import connection
from django.http import JsonResponse
from django.utils.dateparse import parse_datetime
from django.utils.timezone import make_aware
from seeds.models import Seed
from reviews.models import Review, Comment
from django.contrib.sessions.models import Session
import uuid
from django.db import transaction
from django.shortcuts import render, redirect, get_object_or_404


def get_seeds_to_localstorage(request):
    try:
        seeds = Seed.objects.filter(deleted=False).values()
        
        # Convert CloudinaryField to a serializable format
        for seed in seeds:
            if seed['image']:
                seed['image'] = str(seed['image'])  # Convert to string URL
        
        seeds_data = list(seeds)  # Convert QuerySet to a list of dictionaries
        return JsonResponse({'seeds': seeds_data})
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)


def get_cart_data(request):
    try:
        logger.info(f"Fetching cart for user: {request.user.username}")

        # Get the current user's cart
        cart = Cart.objects.get(user=request.user)
        logger.info(f"Cart found for user {request.user.username}: Cart ID {cart.id}")

        # Prepare cart data to be serialized
        cart_data = {
            'id': cart.id,
            'user': cart.user.username,
            'created_at': cart.created_at.isoformat(),
            'updated_at': cart.updated_at.isoformat(),
            'total_price': float(cart.get_total_price()),  # Simplified to include total price only
            'items': []
        }

        logger.info(f"Cart details: {cart_data}")

        # Loop through the cart items and add them to the cart_data
        for item in cart.items.all():
            item_data = {
                'id': item.id,
                'seed': {
                    'id': item.seed.id,
                    'name': item.seed.name,
                    'price': float(item.seed.price),  # Directly use the price as float
                    'image': str(item.seed.image),  # Convert image URL to string
                    'is_in_stock': item.seed.is_in_stock  # Indicate if the seed is in stock
                },
                'quantity': item.quantity,
                'total_price': float(item.get_total_price()),  # Use total price as float
            }
            cart_data['items'].append(item_data)

        logger.info(f"Cart items processed: {cart_data['items']}")

        # Return the cart data as JSON response
        return JsonResponse(cart_data, status=200)

    except Cart.DoesNotExist:
        logger.error(f"Cart not found for user: {request.user.username}")
        return JsonResponse({'error': 'Cart not found'}, status=404)

