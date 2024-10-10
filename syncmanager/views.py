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
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            content = data.get('content')

            if content:
                sender = request.user  # Get the currently logged-in user
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
                        'sender': sender.username,  # Include sender's username
                        'content': message.content,
                        'sent_at': message.sent_at.isoformat(),  # Use ISO format for datetime
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
    # Fetch the conversation, ensuring it's not marked as deleted
    conversation = get_object_or_404(ChatConversation, pk=conversation_id, deleted=False)

    # Fetch messages associated with this conversation, ordered by when they were sent
    messages = ChatMessage.objects.filter(conversation=conversation).order_by('sent_at')  # Use 'sent_at' instead of 'timestamp'

    # Prepare the response data
    message_data = []
    for message in messages:
        message_data.append({
            'id': message.id,
            'sender': message.sender.username,  # Assuming 'sender' is a ForeignKey to User
            'content': message.content,
            'sent_at': message.sent_at.isoformat(),  # Use 'sent_at' instead of 'timestamp'
        })

    return JsonResponse({'messages': message_data})



def get_user_conversations(request, user_id):
    # Fetch the user
    user = get_object_or_404(User, pk=user_id)

    # Fetch conversations where the superuser is involved
    conversations = ChatConversation.objects.filter(
        superuser=user
    ).filter(deleted=False)

    # Prepare the response data
    conversation_data = []
    for conversation in conversations:
        # Fetch unseen messages for this conversation
        unseen_messages = conversation.messages.filter(seen=False).exclude(sender=user)

        # Prepare unseen messages data (you can adjust fields as needed)
        unseen_messages_data = [{'id': msg.id, 'content': msg.content} for msg in unseen_messages]

        conversation_data.append({
            'id': conversation.id,
            'user': conversation.user.username,
            'superuser': conversation.superuser.username,
            'started_at': conversation.started_at.isoformat(),
            'unseenMessagesCount': unseen_messages.count(),
            'unseenMessages': unseen_messages_data,  # Include unseen messages in the response
        })

    return JsonResponse({'conversations': conversation_data})

# Define a constant for the anonymous user ID
ANONYMOUS_USER_ID = 0  # Adjust this as needed

def get_user_id(request):
    if request.user.is_authenticated:
        user_id = request.user.id  # Get the logged-in user's ID
    else:
        user_id = ANONYMOUS_USER_ID  # Handle as an anonymous user

    return JsonResponse({'user_id': user_id})


@login_required
def get_user_messages(request):
    """Fetch messages for the logged-in user."""
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
            'sender': message.sender.username,  # Correctly access the username
            'sent_at': message.sent_at,
            'conversation_id': message.conversation.id  # Adjusted field name for clarity
        } for message in messages]

        return JsonResponse({'messages': message_list})

    except Exception as e:
        print(f"Error fetching user messages: {str(e)}")
        return JsonResponse({'error': 'An error occurred while fetching messages.'}, status=500)


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



def get_username(request):
    username = request.user.username
    return JsonResponse({'username': username})

@login_required
def check_superuser_status(request):
    """Check if the user is authenticated and whether they are a superuser."""
    is_superuser = request.user.is_superuser
    is_authenticated = request.user.is_authenticated  # Check if the user is authenticated
    return JsonResponse({'isSuperUser': is_superuser, 'isAuthenticated': is_authenticated})

@login_required
def get_message_counts(request):
    """View to return message counts for the logged-in user."""
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
    try:
        data = json.loads(request.body)
        logger.info(f"Received data: {data}")  # Log the incoming data
        
        message_ids = data.get('messageIds')  # Get the list of message IDs
        seen = data.get('isSeen', True)  # Default to True if not specified

        # Validate that message_ids is a list and is not empty
        if not isinstance(message_ids, list) or not message_ids:
            return JsonResponse({'error': 'Invalid message IDs provided.'}, status=400)

        # Update the is_seen status of the messages in the database
        updated_count = ChatMessage.objects.filter(id__in=message_ids).update(seen=seen)

        if updated_count == 0:
            logger.warning(f"No messages updated for IDs: {message_ids}")  # Log if no messages were updated
            return JsonResponse({'error': 'No messages updated. Check if message IDs are valid.'}, status=404)

        return JsonResponse({'message': 'Message status updated successfully.'}, status=200)

    except json.JSONDecodeError:
        logger.error("Invalid JSON received")
        return JsonResponse({'error': 'Invalid JSON received.'}, status=400)
    except Exception as e:
        logger.error(f"Error: {str(e)}")  # Log any other errors
        return JsonResponse({'error': str(e)}, status=500)