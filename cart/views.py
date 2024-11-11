"""
This module provides API endpoints and view functions for managing a shopping cart. It includes endpoints 
to add items to a cart, update item quantities, delete items, and render the cart view template.
The module supports both authenticated user sessions and guest sessions, using session IDs to manage 
carts for unauthenticated users. Errors are logged to assist with debugging in case of invalid data 
or unexpected behavior.
"""
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
    """
    Renders the cart view page.
    This function serves the cart HTML template for the client, displaying items in the user's cart.
    """
    return render(request, "cart/cart.html")


logger = logging.getLogger(__name__)


@csrf_exempt
@require_POST
def add_to_cart(request):
    """
    Adds an item to the user's cart.

    This function accepts a POST request with JSON data containing the seed ID and quantity. It validates the input,
    retrieves or creates a cart (depending on the user's authentication status), and adds the specified item to
    the cart. If the item already exists, it updates the quantity instead. A JSON response with cart details is returned.

    Parameters:
        - request (HttpRequest): The HTTP request containing JSON data with seed ID and quantity.

    Returns:
        JsonResponse: A response containing the updated cart data if successful, or an error message if unsuccessful.
    """
    try:
        data = json.loads(request.body)
        seed_id = data.get("seed_id")
        quantity = int(data.get("quantity", 1))

        if not seed_id or quantity <= 0:
            logger.error(
                f"Invalid input: seed_id={seed_id}, quantity={quantity}"
            )
            return HttpResponseBadRequest("Invalid input")
        # Get or create the cart for the user

        if request.user.is_authenticated:
            cart, created = Cart.objects.get_or_create(user=request.user)
            
        else:
          
            session_key = request.session.session_key
            if not session_key:
                request.session.save()  # Ensure a session is created
                session_key = request.session.session_key
            cart, created = Cart.objects.get_or_create(session_id=session_key)
           
        # Get the seed object

        try:
            seed = Seed.objects.get(id=seed_id)
        except Seed.DoesNotExist:
            logger.error(f"Seed with ID {seed_id} not found")
            return JsonResponse({"error": "Seed not found"}, status=404)
        # Get or create the cart item

        cart_item, created = CartItem.objects.get_or_create(
            cart=cart, seed=seed, defaults={"quantity": quantity}
        )

        if not created:
            # Update the quantity of the existing cart item

            cart_item.quantity += quantity
            cart_item.save()
      
        cart_data = {
            "id": cart.id,
            "total_price": float(cart.get_total_price()),
            "total_discount": float(cart.get_total_discount()),
            "delivery_cost": float(cart.get_delivery_cost()),
            "grand_total": float(cart.get_grand_total()),
            "items": [],
        }

        for item in cart.items.all():
            item_price = item.seed.price  # This is likely already a Decimal
            item_discount = Decimal(item.seed.discount or 0)
            discounted_price = item_price - (
                item_price * (item_discount / Decimal(100))
            )

            item_data = {
                "id": item.id,
                "seed": {
                    "id": item.seed.id,
                    "name": item.seed.name,
                    "price": float(discounted_price),
                    "is_in_stock": item.seed.is_in_stock,
                },
                "quantity": item.quantity,
                "total_price": float(item.get_total_price()),
            }
            cart_data["items"].append(item_data)
        return JsonResponse(cart_data, status=200)
    except Exception as e:
        logger.error(f"An error occurred: {str(e)}")
        return JsonResponse({"error": str(e)}, status=500)


@csrf_exempt
def update_quantity(request):
    """
    Updates the quantity of an item in the user's cart.

    This function accepts a POST request with JSON data containing the cart ID, seed ID, and the new quantity.
    It validates the input and updates the quantity of the specified item in the user's cart.

    Parameters:
        - request (HttpRequest): The HTTP request containing JSON data with cart ID, seed ID, and quantity.

    Returns:
        JsonResponse: A response indicating success and the new quantity if successful, or an error message if unsuccessful.
    """
    if request.method == "POST":
        try:
            data = json.loads(request.body)
            cart_id = data.get("cart_id")
            seed_id = data.get("seed_id")
            new_quantity = data.get("quantity")

            if not all([cart_id, seed_id, new_quantity]):
                return JsonResponse(
                    {"error": "Missing parameters"}, status=400
                )
            cart = get_object_or_404(Cart, id=cart_id)
            cart_item, created = CartItem.objects.get_or_create(
                cart=cart, seed_id=seed_id
            )
            cart_item.quantity = new_quantity
            cart_item.save()

            return JsonResponse(
                {"success": True, "new_quantity": cart_item.quantity}
            )
        except json.JSONDecodeError:
            return JsonResponse({"error": "Invalid JSON"}, status=400)
    return JsonResponse({"error": "Only POST method allowed"}, status=405)


@csrf_exempt
@require_POST
def delete_item(request):
    """
    Deletes an item from the user's cart.

    This function accepts a POST request with JSON data containing the cart ID and seed ID. 
    It validates the input and removes the specified item from the user's cart.

    Parameters:
        - request (HttpRequest): The HTTP request containing JSON data with cart ID and seed ID.

    Returns:
        JsonResponse: A response indicating success if successful, or an error message if unsuccessful.
    """
    if request.method == "POST":
        try:
            data = json.loads(request.body)
            cart_id = data.get("cart_id")
            seed_id = data.get("seed_id")

            if not cart_id or not seed_id:
                return JsonResponse(
                    {"error": "Missing parameters"}, status=400
                )
            cart = get_object_or_404(Cart, id=cart_id)
            cart_item = CartItem.objects.filter(
                cart=cart, seed_id=seed_id
            ).first()

            if not cart_item:
                return JsonResponse(
                    {"error": "Item not found in cart"}, status=404
                )
            cart_item.delete()

            return JsonResponse({"success": True}, status=200)
        except json.JSONDecodeError:
            return JsonResponse({"error": "Invalid JSON"}, status=400)
    return JsonResponse({"error": "Only POST method allowed"}, status=405)
