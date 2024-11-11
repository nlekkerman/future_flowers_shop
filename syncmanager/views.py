# syncmanager/views.py

from django.http import JsonResponse, HttpResponseBadRequest
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_http_methods, require_POST, require_GET
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
from communications.models import ChatMessage, ChatConversation
from django.contrib.auth import get_user_model
from django.db.models import Q

def custom_404_view(request, exception=None):
    """
    Custom view to handle 404 errors (Page Not Found).
    The 'exception' parameter is required for Django to pass the error details.
    """
    return render(request, 'custom_accounts/404.html', status=404)

    
User = get_user_model()
@csrf_exempt
def send_message(request, conversation_id):
    """
    Handles sending a message in a specific conversation identified by `conversation_id`.
    The message content is expected to be in the body of the POST request as JSON.
    
    Args:
        request (HttpRequest): The HTTP request object, which contains the body with the message content.
        conversation_id (int): The ID of the conversation to send the message to.

    Returns:
        JsonResponse: A JSON response indicating the success or failure of the operation.
            - Success case: Contains message ID, sender, content, and sent timestamp.
            - Failure case: Contains an error message and appropriate HTTP status code.
    """
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            content = data.get('content')

            if content:
                sender = request.user
                conversation = ChatConversation.objects.get(id=conversation_id)

                # Create the new message
                message = ChatMessage.objects.create(
                    conversation=conversation,
                    sender=sender,
                    content=content
                )

                # Prepare the response data with the new message
                response_data = {
                    'success': True,
                    'message': {
                        'id': message.id,
                        'sender': sender.username, 
                        'content': message.content,
                        'sent_at': message.sent_at.isoformat(),
                    }
                }
                return JsonResponse(response_data)

            return JsonResponse({'success': False, 'error': 'Content is required'}, status=400)

        except ChatConversation.DoesNotExist:
            return JsonResponse({'success': False, 'error': 'Conversation not found'}, status=404)
        except Exception as e:
            return JsonResponse({'success': False, 'error': str(e)}, status=500)

    return JsonResponse({'success': False, 'error': 'Invalid request method'}, status=405)

@login_required  # Ensure the user is logged in
def fetch_messages(request, conversation_id):
    """
    Fetches all messages in a specific conversation identified by `conversation_id`.
    
    Args:
        request (HttpRequest): The HTTP request object.
        conversation_id (int): The ID of the conversation whose messages need to be fetched.
    
    Returns:
        JsonResponse: 
            - Success: A JSON response containing all messages in the conversation.
            - Failure: A JSON response with an error message and an appropriate HTTP status code (404, 500, 405, 403).
    """
    if request.method == 'GET':
        try:
            # Get the conversation by ID
            conversation = ChatConversation.objects.get(id=conversation_id)

            # Check if the logged-in user is a participant in the conversation
            if request.user not in conversation.participants.all():  # Assuming participants is a ManyToManyField
                return JsonResponse({'success': False, 'error': 'You do not have permission to access this conversation.'}, status=403)

            # Fetch messages related to this conversation
            messages = ChatMessage.objects.filter(conversation=conversation).order_by('sent_at')

            # Prepare messages for response
            messages_data = [{
                'id': message.id,
                'sender': message.sender.username,
                'content': message.content,
                'sent_at': message.sent_at.isoformat(),
            } for message in messages]

            return JsonResponse({'success': True, 'messages': messages_data})

        except ChatConversation.DoesNotExist:
            return JsonResponse({'success': False, 'error': 'Conversation not found'}, status=404)
        except Exception as e:
            return JsonResponse({'success': False, 'error': str(e)}, status=500)

    return JsonResponse({'success': False, 'error': 'Invalid request method'}, status=405)

def get_conversation_messages(request, conversation_id):
    """
    Fetches all messages for a specific conversation, ensuring the conversation is not marked as deleted.
    
    Args:
        request (HttpRequest): The HTTP request object.
        conversation_id (int): The ID of the conversation whose messages need to be fetched.
    
    Returns:
        JsonResponse: A JSON response containing the messages of the conversation.
    """
    conversation = get_object_or_404(ChatConversation, pk=conversation_id, deleted=False)

    # Fetch messages associated with this conversation, ordered by when they were sent
    messages = ChatMessage.objects.filter(conversation=conversation).order_by('sent_at')

    # Prepare the response data
    message_data = []
    for message in messages:
        message_data.append({
            'id': message.id,
            'sender': message.sender.username, 
            'content': message.content,
            'sent_at': message.sent_at.isoformat(),
        })

    return JsonResponse({'messages': message_data})
    
def get_user_conversations(request, user_id):
    """
    Fetches conversations involving a specific user, checking if they are a superuser.
    
    Args:
        request (HttpRequest): The HTTP request object.
        user_id (int): The ID of the user whose conversations need to be fetched.
    
    Returns:
        JsonResponse: 
            - Success: A JSON response containing the list of conversations.
            - Failure: A JSON response with an error message and appropriate status code.
    """
    user = get_object_or_404(User, pk=user_id)

    # Check if the logged-in user is a superuser
    if user.is_superuser:
        # Fetch conversations where the superuser is involved with other users
        conversations = ChatConversation.objects.filter(
            superuser=user
        ).filter(deleted=False)

        # If no conversations exist, return a message
        if not conversations.exists():
            return JsonResponse({'message': 'No conversations found for this superuser.'})

    else:
        # Fetch conversations where the logged-in user is involved
        conversations = ChatConversation.objects.filter(
            user=user
        ).filter(deleted=False)

        # If there are no conversations, try to create one with a superuser
        if not conversations.exists():
            # Find any superuser in the database
            superuser = User.objects.filter(is_superuser=True).first()
            if superuser:
                # Create a new conversation between the user and the superuser
                conversation = ChatConversation.objects.create(
                    user=user,
                    superuser=superuser
                )
                initial_message_content = "Welcome to Future Flower Shop! Enjoy exploring seeds and gardening with us."
                ChatMessage.objects.create(
                    conversation=conversation,
                    sender=superuser,
                    content=initial_message_content
                )
                return JsonResponse({
                    'message': 'No existing conversations found. Created a new conversation with a superuser.',
                    'conversation_id': conversation.id,
                })
            else:
                return JsonResponse({'message': 'No superuser available to create a conversation with.'})

    # Prepare the response data for existing conversations
    conversation_data = []
    for conversation in conversations:
        # Fetch unseen messages for this conversation
        unseen_messages = conversation.messages.filter(seen=False).exclude(sender=user)

        # Prepare unseen messages data
        unseen_messages_data = [{'id': msg.id, 'content': msg.content} for msg in unseen_messages]

        conversation_data.append({
            'id': conversation.id,
            'user': conversation.user.username,
            'superuser': conversation.superuser.username,
            'started_at': conversation.started_at.isoformat(),
            'unseenMessagesCount': unseen_messages.count(),
            'unseenMessages': unseen_messages_data,
        })

    return JsonResponse({'conversations': conversation_data})



# Define a constant for the anonymous user ID
ANONYMOUS_USER_ID = 0  

def get_user_id(request):
    """
    Returns the user ID for the logged-in user or a constant value for anonymous users.
    
    Args:
        request (HttpRequest): The HTTP request object.
    
    Returns:
        JsonResponse: A JSON response with the user ID.
    """
    if request.user.is_authenticated:
        user_id = request.user.id 
    else:
        user_id = ANONYMOUS_USER_ID 

    return JsonResponse({'user_id': user_id})


@login_required
def get_user_messages(request):
    """
    Fetches messages for the logged-in user.
    
    Args:
        request (HttpRequest): The HTTP request object.
    
    Returns:
        JsonResponse: A JSON response containing the user's messages.
    """
    try:
        user = request.user
        
        # Get all conversations the user is part of
        conversations = ChatConversation.objects.filter(user=user) | ChatConversation.objects.filter(superuser=user)

        # Fetch messages for those conversations
        messages = ChatMessage.objects.filter(conversation__in=conversations).select_related('sender')

        # Prepare the message list with the desired format
        message_list = [{
            'id': message.id,
            'content': message.content,
            'sender': message.sender.username,
            'sent_at': message.sent_at,
            'conversation_id': message.conversation.id 
        } for message in messages]

        return JsonResponse({'messages': message_list})

    except Exception as e:
        print(f"Error fetching user messages: {str(e)}")
        return JsonResponse({'error': 'An error occurred while fetching messages.'}, status=500)


def get_seeds_to_localstorage(request):
    """
    Retrieves all seeds that are not marked as deleted and processes them for sending to local storage.
    It also calculates the discounted price for each seed if a discount is applied.

    Args:
        request (HttpRequest): The HTTP request object.

    Returns:
        JsonResponse: 
            - Success: A JSON response containing the seed data, including name, price, image, and discounted price.
            - Failure: A JSON response with an error message and status 500 if an exception occurs.
    """
    try:
        
        seeds = Seed.objects.filter(deleted=False).values()

        # Convert CloudinaryField to a serializable format and calculate discounted price
        seeds_data = []
        for seed in seeds:
            if seed['image']:
                seed['image'] = str(seed['image']) 
            
            # Calculate discounted price
            price = float(seed['price']) 
            discount = float(seed['discount']) 
            if discount > 0:
                discounted_price = price - (price * (discount / 100))
                logger.debug(f"Calculated discounted price: {discounted_price}")
            else:
                discounted_price = price
            
            seed['discounted_price'] = round(discounted_price, 2)

            seeds_data.append(seed)
        
        return JsonResponse({'seeds': seeds_data})
    except Exception as e:
        logger.error(f"Error occurred: {str(e)}", exc_info=True)
        return JsonResponse({'error': str(e)}, status=500)


def get_cart_data(request):
    """
    Retrieves cart data for the logged-in user or anonymous users (based on session).

    Args:
        request (HttpRequest): The HTTP request object.

    Returns:
        JsonResponse: 
            - Success: A JSON response containing the user's cart data (ID, user, items, total price).
            - Failure: A JSON response with an error message and status 500 if an exception occurs.
    """
    try:
        if request.user.is_authenticated:
            # Fetch cart for logged-in user
            cart, created = Cart.objects.get_or_create(user=request.user)
        else:
            # Handle anonymous users (session-based cart)
            if not request.session.session_key:
                request.session.create() 

            session_key = request.session.session_key
            # Fetch or create cart for the session
            cart, created = Cart.objects.get_or_create(session_id=session_key, user=None)

        # Prepare cart data to be serialized
        cart_data = {
            'id': cart.id,
            'user': request.user.username if request.user.is_authenticated else 'Anonymous',
            'created_at': cart.created_at.isoformat(),
            'updated_at': cart.updated_at.isoformat(),
            'total_price': float(cart.get_total_price()), 
            'items': []
        }


        # Loop through the cart items and handle discount properly
        for item in cart.items.all():
            item_price = item.seed.price
            item_discount = item.seed.discount or 0
            if item_discount > 0:
                # Calculate the discounted price
                discounted_price = item_price - (item_price * (item_discount / 100))
                price_to_use = discounted_price 
            else:
                price_to_use = item_price

            # Add item data to cart_data
            item_data = {
                'id': item.id,
                'seed': {
                    'id': item.seed.id,
                    'name': item.seed.name,
                    'price': float(price_to_use),
                    'image': str(item.seed.image),
                    'is_in_stock': item.seed.is_in_stock
                },
                'quantity': item.quantity,
                'total_price': float(item.get_total_price()),
            }
            cart_data['items'].append(item_data)


        # Return the cart data as JSON response
        return JsonResponse(cart_data, status=200)

    except Exception as e:
        logger.error(f"An error occurred while fetching cart data: {str(e)}")
        return JsonResponse({'error': 'An error occurred while fetching cart data'}, status=500)



def get_username(request):
    """
    Retrieves the username of the logged-in user.

    Args:
        request (HttpRequest): The HTTP request object.

    Returns:
        JsonResponse: A JSON response containing the logged-in user's username.
    """
    username = request.user.username
    return JsonResponse({'username': username})


def check_superuser_status(request):
    """
    Checks if the logged-in user is a superuser and if they are authenticated.

    Args:
        request (HttpRequest): The HTTP request object.

    Returns:
        JsonResponse: A JSON response containing the superuser status and authentication status.
    """
    is_superuser = request.user.is_superuser
    is_authenticated = request.user.is_authenticated 
    return JsonResponse({'isSuperUser': is_superuser, 'isAuthenticated': is_authenticated})

@login_required
def get_message_counts(request):
    """
    Returns the message counts for the logged-in user, including total messages and unseen messages.

    Args:
        request (HttpRequest): The HTTP request object.

    Returns:
        JsonResponse: 
            - Success: A JSON response containing the total message count and unseen message count.
            - Failure: A JSON response with an error message and status 500 if an exception occurs.
    """
    try:
        user = request.user

        # Filter conversations where the logged-in user is either the user or the superuser
        conversations = ChatConversation.objects.filter(
            Q(user=user) | Q(superuser=user)
        )

        # Total messages for the user in all conversations (as either user or superuser)
        total_messages_count = ChatMessage.objects.filter(conversation__in=conversations).count()

        # Unseen messages count for the user (messages not sent by the user)
        unseen_messages_count = ChatMessage.objects.filter(
            conversation__in=conversations,
            seen=False
        ).exclude(sender=user).count()

        return JsonResponse({
            'totalMessages': total_messages_count,
            'unseenMessages': unseen_messages_count
        })
    except Exception as e:
        # Log the exception or print it for debugging purposes
        print(f"Error occurred while fetching message counts: {e}")
        return JsonResponse({'error': 'An error occurred while fetching message counts.'}, status=500)


@csrf_exempt
@require_POST
def update_message_status(request):
    """
    Updates the status of a message (e.g., marking it as seen).

    Args:
        request (HttpRequest): The HTTP request object, containing the message ID and status to be updated.

    Returns:
        JsonResponse: 
            - Success: A JSON response indicating the success of the status update.
            - Failure: A JSON response with an error message and status 500 if an exception occurs.
    """
    try:
        data = json.loads(request.body)
        logger.info(f"Received data: {data}")
        
        message_ids = data.get('messageIds')
        seen = data.get('isSeen', True)

        if not isinstance(message_ids, list) or not message_ids:
            return JsonResponse({'error': 'Invalid message IDs provided.'}, status=400)

        updated_count = ChatMessage.objects.filter(id__in=message_ids).update(seen=seen)

        if updated_count == 0:
            logger.warning(f"No messages updated for IDs: {message_ids}")
            return JsonResponse({'error': 'No messages updated. Check if message IDs are valid.'}, status=404)

        return JsonResponse({'message': 'Message status updated successfully.'}, status=200)

    except json.JSONDecodeError:
        logger.error("Invalid JSON received")
        return JsonResponse({'error': 'Invalid JSON received.'}, status=400)
    except Exception as e:
        logger.error(f"Error: {str(e)}")
        return JsonResponse({'error': str(e)}, status=500)