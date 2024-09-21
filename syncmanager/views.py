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

        # Convert CloudinaryField to a serializable format and calculate discounted price
        seeds_data = []
        for seed in seeds:
            if seed['image']:
                seed['image'] = str(seed['image'])  # Convert to string URL
            
            # Calculate discounted price
            price = float(seed['price'])  # Convert price to float
            discount = float(seed['discount'])  # Convert discount to float

            if discount > 0:
                discounted_price = price - (price * (discount / 100))
                logger.debug(f"Calculated discounted price: {discounted_price}")
            else:
                discounted_price = price
            
            seed['discounted_price'] = round(discounted_price, 2)  # Add discounted price to seed

            seeds_data.append(seed)
        
        return JsonResponse({'seeds': seeds_data})
    except Exception as e:
        logger.error(f"Error occurred: {str(e)}", exc_info=True)
        return JsonResponse({'error': str(e)}, status=500)


def get_cart_data(request):
    try:
        if request.user.is_authenticated:
            # Fetch cart for logged-in user
            cart, created = Cart.objects.get_or_create(user=request.user)
        else:
            # Handle anonymous users (session-based cart)
            if not request.session.session_key:
                request.session.create()  # Create a new session if not already created

            session_key = request.session.session_key
            # Fetch or create cart for the session
            cart, created = Cart.objects.get_or_create(session_id=session_key, user=None)

        # Prepare cart data to be serialized
        cart_data = {
            'id': cart.id,
            'user': request.user.username if request.user.is_authenticated else 'Anonymous',
            'created_at': cart.created_at.isoformat(),
            'updated_at': cart.updated_at.isoformat(),
            'total_price': float(cart.get_total_price()),  # Simplified to include total price only
            'items': []
        }


        # Loop through the cart items and handle discount properly
        for item in cart.items.all():
            item_price = item.seed.price
            item_discount = item.seed.discount or 0  # Check if there's a discount
            if item_discount > 0:
                # Calculate the discounted price
                discounted_price = item_price - (item_price * (item_discount / 100))
                price_to_use = discounted_price  # Use discounted price if applicable
            else:
                price_to_use = item_price  # Use regular price if no discount

            # Add item data to cart_data
            item_data = {
                'id': item.id,
                'seed': {
                    'id': item.seed.id,
                    'name': item.seed.name,
                    'price': float(price_to_use),  # Use the discounted price if applicable
                    'image': str(item.seed.image),  # Convert image URL to string
                    'is_in_stock': item.seed.is_in_stock  # Indicate if the seed is in stock
                },
                'quantity': item.quantity,
                'total_price': float(item.get_total_price()),  # Use total price as float
            }
            cart_data['items'].append(item_data)


        # Return the cart data as JSON response
        return JsonResponse(cart_data, status=200)

    except Exception as e:
        logger.error(f"An error occurred while fetching cart data: {str(e)}")
        return JsonResponse({'error': 'An error occurred while fetching cart data'}, status=500)



