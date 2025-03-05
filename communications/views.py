import json
from rest_framework import permissions
from rest_framework.response import Response
from rest_framework.views import APIView
from django.shortcuts import render, redirect, get_object_or_404
from django.http import JsonResponse
from django.contrib.auth.decorators import login_required
from django.views.decorators.http import require_POST
from django.urls import reverse
from .models import Conversation, ChatMessage
from django.contrib.auth.models import User
from .forms import ChatMessageForm
from django.db.models import Max, Q
import logging

"""
This module handles the views for the communications app, which facilitates chat functionality between users and admins (superusers). The following views are implemented:

1. **conversations**: Displays a list of all conversations for the logged-in superuser. The view allows search functionality to filter conversations based on the username of the other user in the conversation. It also tracks unread messages and sorts conversations by the latest message sent.

2. **chat_with_user**: Allows superusers to chat with a selected user. The chat interface displays all messages in the conversation and marks any unread messages as read.

3. **send_message_to_user**: Allows a superuser to send a message to a selected user within an ongoing conversation. The message is sent through a POST request, and the response includes the new message's content, sender, and timestamp.

4. **chat_with_admin**: Allows a regular user to chat with a superuser (admin). The chat interface displays all messages exchanged in the conversation with the admin.

5. **send_message_to_admin**: Allows a regular user to send a message to the superuser (admin). Similar to the `send_message_to_user` view, the message is sent via a POST request, and the response includes the new message details.

6. **contact_view**: Renders the contact page where users can reach out for inquiries or support.

7. **about**: Renders the about page, typically containing general information about the website or company.

8. **faq_view**: Renders the FAQ (Frequently Asked Questions) page, providing answers to common questions users might have about delivery, seed storage, returns, and more.

9. **search_users**: Allows admin users to search for other users by username, returning a list of matching users in JSON format.

The views use Django’s built-in authentication system to restrict access based on user roles (admin or regular user). They also use Django's ORM to interact with the database models (`Conversation`, `ChatMessage`, `User`).
"""


# Set up the logger
logger = logging.getLogger(__name__)



@login_required
def conversations(request):
    """
    View that displays all conversations for a superuser. 
    Allows superusers to search conversations by username, 
    view unread messages count, and sort conversations by the latest message.
    If a search is made, it redirects to a chat with the selected user if a conversation exists or creates a new one.
    
    Returns:
        - A rendered template displaying conversations with the unread message count and search query.
    """
    
    if not request.user.is_superuser:
        return redirect("home")

    search_query = request.GET.get("search", "").strip()

    unread_messages_count = ChatMessage.objects.filter(
        receiver=request.user, is_read=False, is_deleted=False
    ).count()

    conversations = Conversation.objects.all()

    if search_query:
        conversations = conversations.filter(
            Q(user__username__icontains=search_query)
        )

    for conversation in conversations:
        conversation.last_message = conversation.messages.order_by('-sent_at').first()

    conversations = sorted(
        conversations,
        key=lambda x: x.last_message.sent_at if x.last_message else x.created_at,
        reverse=True
    )    

    if search_query:
        user = request.user
        searched_user = Conversation.objects.filter(user__username__icontains=search_query).first()

        if searched_user:
            conversation = Conversation.objects.filter(user=searched_user, created_by=user).first()
            if not conversation:
                conversation = Conversation.objects.create(user=searched_user, created_by=user)
            return redirect('communications:chat_with_user', user_id=searched_user.id)

    return render(request, "communications/conversations.html", {
        "conversations": conversations,
        "unread_messages_count": unread_messages_count,
        "search_query": search_query,
    })

@login_required
def chat_with_user(request, user_id):
    """
    View that allows a superuser to chat with a specific user.
    If no conversation exists, it creates one. It retrieves all messages from that conversation, 
    marks unread messages as read, and displays them. 
    Also counts and displays the unread messages for the superuser.

    Parameters:
        - request (HttpRequest): The HTTP request object, which contains details about the current session and user.
        - user_id (int): The ID of the user the superuser is chatting with.

    Returns:
        - HttpResponse: The rendered template displaying the chat messages, the selected user, and the unread message count.
    """

    if not request.user.is_superuser:
        return redirect("home")

    selected_user = get_object_or_404(User, id=user_id)

    active_conversation, created = Conversation.objects.get_or_create(
        superuser=request.user, user=selected_user
    )

    chat_messages = active_conversation.messages.all().order_by("sent_at")

    active_conversation.messages.filter(is_read=False).update(is_read=True)
    
    unread_messages_count = ChatMessage.objects.filter(
            receiver=request.user, is_read=False, is_deleted=False
        ).count()
    
    return render(request, "communications/chat_with_user.html", {
        "selected_user": selected_user,
        "chat_messages": chat_messages,
        "active_conversation": active_conversation,
        "unread_messages_count": unread_messages_count,
    })

@login_required
@require_POST
def send_message_to_user(request, conversation_id):
    """
    View that allows a superuser to send a message to a specific user in an existing conversation.
    It checks if the user is a superuser, retrieves the conversation by ID, and processes the message form.
    If the form is valid, the message is created and returned as a JSON response with message details. 
    If the form is invalid, an error message is returned.

    Parameters:
        - request (HttpRequest): The HTTP request object, containing details about the current session, user, and POST data.
        - conversation_id (int): The ID of the conversation where the message is being sent.

    Returns:
        - JsonResponse: The JSON response contains the message details if successful, or an error message if the form is invalid.
    """
    if not request.user.is_superuser:
        return redirect("communications:chat_with_admin")

    conversation = get_object_or_404(Conversation, id=conversation_id)
    form = ChatMessageForm(request.POST)

    if form.is_valid():
        message = ChatMessage.objects.create(
            conversation=conversation,
            sender=request.user,
            receiver=conversation.user,
            content=form.cleaned_data["content"]
        )

        response_data = {
            "message": message.content,
            "sender": message.sender.username,
            "sent_at": message.sent_at.strftime("%b %d, %Y %H:%M"),
        }
        
        return JsonResponse(response_data)

    return JsonResponse({"error": "Invalid message form"}, status=400)


@login_required
def chat_with_admin(request):
    """
    View for a regular user to chat with the superuser (admin). The flow ensures only non-superusers
    can access this view and handles the creation of conversations between the user and the superuser.

    **Key steps**:
    - Ensures only non-superusers can access the view; redirects superusers to their conversations page.
    - Retrieves the first available superuser (admin) to start a chat.
    - If no admin is available, renders an error message.
    - Creates a conversation between the regular user and the superuser if one doesn't already exist.
    - Marks all unread messages in the conversation as read.
    - Displays the chat messages in chronological order.
    
    **Parameters**:
    - request (HttpRequest): Contains the session and user data.

    **Returns**:
    - HttpResponse: The rendered HTML page containing the conversation messages, or an error page if no admin is available.
    """

    if request.user.is_superuser:
        return redirect("communications:conversations")

    superuser = User.objects.filter(is_superuser=True).first()
    if not superuser:
        return render(request, "communications/chat_messages.html", {"error": "No admin available"})

    conversation, created = Conversation.objects.get_or_create(
        superuser=superuser,
        user=request.user
    )

    unread_messages = conversation.messages.filter(is_read=False, receiver=request.user)
    unread_messages.update(is_read=True)
    chat_messages = conversation.messages.all().order_by("sent_at")

    return render(request, "communications/chat_messages.html", {
        "conversation": conversation,
        "chat_messages": chat_messages,
        "selected_user": superuser,
    })

@login_required
@require_POST
def send_message_to_admin(request, conversation_id):
    """
    Regular user sends a message to the superuser (admin) in an existing conversation.

    **Key steps**:
    - Validates that the request method is POST and that the user is logged in.
    - Retrieves the conversation using the provided `conversation_id`.
    - Validates the submitted form data (message content).
    - If valid, creates a new `ChatMessage` and associates it with the current conversation.
    - Prepares the response data, including the sender's username, message content, sent time, and read status.
    - Returns the message details as a JSON response to update the frontend dynamically.
    
    **Parameters**:
    - request (HttpRequest): Contains the form data (message content) and user session information.
    - conversation_id (int): The unique identifier of the conversation to send the message to.

    **Returns**:
    - JsonResponse: Returns a JSON response containing the message details if the form is valid.
    - If the form is invalid, a JSON response with an error message is returned with status 400.
    """
    conversation = get_object_or_404(Conversation, id=conversation_id)
    form = ChatMessageForm(request.POST)

    if form.is_valid():
        message = ChatMessage.objects.create(
            conversation=conversation,
            sender=request.user,
            receiver=conversation.superuser,
            content=form.cleaned_data["content"]
        )

        response_data = {
            'sender': message.sender.username,
            'message': message.content,
            'sent_at': message.sent_at.strftime('%H:%M'),
            'is_read': message.is_read,
        }

        return JsonResponse(response_data)


    return JsonResponse({'error': 'Message not sent.'}, status=400)


def contact_view(request):
    """
    Renders the contact page.

    This view serves the contact page of the website. It typically
    includes a form or other contact
    information, allowing users to reach out to the service or
    company for inquiries, support, or feedback.

    Parameters:
        - request (HttpRequest): The HTTP request object.

    Returns:
        HttpResponse: The rendered HTML page for the contact
        form or contact information.
    """
    return render(request, "communications/contact.html")


def about(request):
    """
    Renders the about page.
    This view serves the about page of the website,
    typically containing general information about
    the service or company, its mission, values, and other relevant details.

    Parameters:
        - request (HttpRequest): The HTTP request object.

    Returns:
        HttpResponse: The rendered HTML page for the about section.
    """
    return render(request, "communications/about.html")


def faq_view(request):
    """
    Renders the FAQ page with frequently asked questions and answers.

    This view provides answers to common questions from users.
    The FAQ section includes information
    about delivery policies, seed storage, return policies,
    and planting instructions. It helps users
    get quick answers to their concerns without needing to
    contact support.

    Parameters:
        - request (HttpRequest): The HTTP request object.

    Returns:
        HttpResponse: The rendered HTML page with a list
        of frequently asked questions and their answers.
    """
    faqs = [
        {
            "question": "What is the delivery policy?",
            "answer": "Delivery is free for orders above $50. For orders under"
            "$50, a small shipping fee applies.",
        },
        {
            "question": "How should I store my seeds?",
            "answer": "Seeds should be stored in a cool, dry place, away from "
            "sunlight to maintain their viability.",
        },
        {
            "question": "Can I return seeds?",
            "answer": "We accept returns for unopened seed packets within "
            "30 days of purchase.",
        },
        {
            "question": "How do I plant my seeds?",
            "answer": "Each seed comes with specific planting instructions on "
            "the packet. Generally, plant them in well-drained soil "
            "and ensure they receive adequate sunlight.",
        },
        {
            "question": "Are the seeds GMO-free?",
            "answer": "Yes, all our seeds are free from genetic modifications "
            "and are naturally grown.",
        },
        {
            "question": "How long do the seeds stay viable?",
            "answer": "Seeds can stay viable for 1-3 years if stored properly,"
            "but it’s best to plant them within the first year.",
        },
        {
            "question": "What is the best season to plant seeds?",
            "answer": "It depends on the type of plant, but most seeds are "
            "best planted in the spring or early summer.",
        },
        {
            "question": "Do you offer international shipping?",
            "answer": "Currently, we only offer shipping within the United "
            "States. We hope to expand internationally in the future.",
        },
        {
            "question": "Can I buy seeds in bulk?",
            "answer": "Yes, we offer bulk discounts for large orders. Contact "
            "us for more information on bulk pricing.",
        },
    ]

    return render(request, "communications/questions.html", {"faqs": faqs})


def search_users(request):
    """
    Fetches a list of users based on a search query entered by the admin. This allows for user search functionality 
    within the admin interface by querying the username.

    **Key steps**:
    - Retrieves the search query from the request parameters (via `GET` request).
    - If no query is provided, it returns an empty list as a JSON response.
    - If a query is provided, it filters the `User` model to find users whose usernames contain the search term (case-insensitive).
    - Limits the results to a maximum of 10 users.
    - Prepares a list of dictionaries containing the `id` and `username` for each matched user.
    - Returns the list of users in a JSON format.

    **Parameters**:
    - request (HttpRequest): The HTTP request object containing the search query (from the `GET` request).

    **Returns**:
    - JsonResponse: A JSON response containing the user data (id and username) for the matched users.
      If no query is provided, it returns an empty list.
    """
    query = request.GET.get("q", "").strip()
    if not query:
        return JsonResponse([], safe=False)

    users = User.objects.filter(Q(username__icontains=query))[:10]
    data = [{"id": user.id, "username": user.username} for user in users]

    return JsonResponse(data, safe=False)