# syncmanager/views.py

from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_http_methods
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
def get_seeds_with_last_sync(request):
    last_sync = request.GET.get('last_sync')
    if last_sync:
        last_sync = parse_datetime(last_sync)
    else:
        last_sync = None

    if last_sync:
        seeds = Seed.objects.filter(last_modified__gt=last_sync, deleted=False)
    else:
        seeds = Seed.objects.filter(deleted=False)

    seeds_data = list(seeds.values())  # Convert to list of dictionaries
    return JsonResponse({'seeds': seeds_data})
      
def get_cart(request):
    user = request.user if request.user.is_authenticated else None
    session_id = request.session.session_key
    
    # Get cart for the authenticated user or by session_id
    if user:
        cart = Cart.objects.filter(user=user, deleted=False).first()
    else:
        cart = Cart.objects.filter(session_id=session_id, deleted=False).first()

    if cart:
        cart_items = CartItem.objects.filter(cart=cart, deleted=False)
        items = [
            {
                "seed_id": item.seed.id,
                "name": item.seed.name,
                "quantity": item.quantity,
                "price": float(item.seed.price),
                "total_price": float(item.get_total_price()),
                "image": str(item.seed.image),
                "in_stock": item.seed.in_stock
            }
            for item in cart_items
        ]
        return JsonResponse({"cart_id": cart.id, "items": items, "total_price": float(cart.get_total_price())})
    else:
        return JsonResponse({"cart_id": None, "items": [], "total_price": 0.0})

@csrf_exempt
@require_http_methods(["POST"])
@login_required
def update_cart(request):
    try:
        data = json.loads(request.body)
        cart_items = data.get('cart', [])
        user = request.user
        session_id = request.session.session_key
        
        # Ensure only one cart per user
        cart, created = Cart.objects.get_or_create(
            user=user,
            defaults={'session_id': session_id, 'deleted': False}
        )

        if created:
            logger.info(f'Created new cart for user {user.id}')
        else:
            logger.info(f'Retrieved existing cart for user {user.id}')

        for item in cart_items:
            seed_id = item.get('seed_id')
            quantity = item.get('quantity', 0)
            
            if quantity <= 0:
                # Remove item from cart
                CartItem.objects.filter(cart=cart, seed_id=seed_id).delete()
            else:
                # Update or add item
                CartItem.objects.update_or_create(
                    cart=cart,
                    seed_id=seed_id,
                    defaults={'quantity': quantity}
                )
        
        return JsonResponse({'status': 'success'})
    except json.JSONDecodeError as e:
        logger.error(f'Error decoding JSON: {e}')
        return JsonResponse({'error': 'Invalid JSON format'}, status=400)
    except Exception as e:
        logger.error(f'Error updating cart: {e}')
        return JsonResponse({'error': str(e)}, status=500)
    try:
        data = json.loads(request.body)
        cart_items = data.get('cart', [])
        user = request.user
        session_id = request.session.session_key

        # Ensure cart exists or create a new one
        cart, created = Cart.objects.get_or_create(user=user, session_id=session_id, defaults={'deleted': False})

        for item in cart_items:
            seed_id = item.get('seed_id')
            quantity = item.get('quantity', 0)

            if not seed_id:
                logger.error('Missing seed_id in cart item')
                continue

            if quantity <= 0:
                # Remove item from cart
                CartItem.objects.filter(cart=cart, seed_id=seed_id).delete()
            else:
                # Update or add item
                CartItem.objects.update_or_create(
                    cart=cart,
                    seed_id=seed_id,
                    defaults={'quantity': quantity}
                )
        
        return JsonResponse({'status': 'success'})
    except json.JSONDecodeError as e:
        logger.error(f'Error decoding JSON: {e}')
        return JsonResponse({'error': 'Invalid JSON format'}, status=400)
    except Exception as e:
        logger.error(f'Error updating cart: {e}')
        return JsonResponse({'error': str(e)}, status=500)