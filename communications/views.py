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

# Set up the logger
logger = logging.getLogger(__name__)



@login_required
def conversations(request):
    """Superuser sees all conversations with search."""
    if not request.user.is_superuser:
        return redirect("home")

    search_query = request.GET.get("search", "").strip()
    
    # Calculate unread messages count
    unread_messages_count = ChatMessage.objects.filter(
        receiver=request.user, is_read=False, is_deleted=False
    ).count()


    # Fetch all conversations
    conversations = Conversation.objects.all()

    # Search filter
    if search_query:
        conversations = conversations.filter(
            Q(user__username__icontains=search_query)
        )

    # Get last message for each conversation
    for conversation in conversations:
        conversation.last_message = conversation.messages.order_by('-sent_at').first()

   
     # Sort conversations by latest message
    conversations = sorted(
        conversations,
        key=lambda x: x.last_message.sent_at if x.last_message else x.created_at,
        reverse=True
    )    
    # Handling conversation creation for the search result
    if search_query:
        user = request.user
        searched_user = Conversation.objects.filter(user__username__icontains=search_query).first()

        if searched_user:
            # If a conversation exists with the user, redirect to that conversation
            conversation = Conversation.objects.filter(user=searched_user, created_by=user).first()
            if not conversation:
                # If no conversation exists, create one
                conversation = Conversation.objects.create(user=searched_user, created_by=user)
            return redirect('communications:chat_with_user', user_id=searched_user.id)

    return render(request, "communications/conversations.html", {
        "conversations": conversations,
        "unread_messages_count": unread_messages_count,
        "search_query": search_query,
    })

@login_required
def chat_with_user(request, user_id):
    """Superusers can chat with users."""
    if not request.user.is_superuser:
        return redirect("home")

  

    # Get the selected user
    selected_user = get_object_or_404(User, id=user_id)

    # Get or create the conversation between the superuser and the selected user
    active_conversation, created = Conversation.objects.get_or_create(
        superuser=request.user, user=selected_user
    )

    # Get all messages for this conversation
    chat_messages = active_conversation.messages.all().order_by("sent_at")

    # Mark messages as read if they're unread
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
    """Superuser sends message to a selected user."""
    if not request.user.is_superuser:
        return redirect("communications:chat_with_admin")

    conversation = get_object_or_404(Conversation, id=conversation_id)
    form = ChatMessageForm(request.POST)

    if form.is_valid():
        message = ChatMessage.objects.create(
            conversation=conversation,
            sender=request.user,  # Superuser is the sender
            receiver=conversation.user,  # Selected user is the receiver
            content=form.cleaned_data["content"]
        )
        # Return the new message as a JSON response
        response_data = {
            "message": message.content,
            "sender": message.sender.username,
            "sent_at": message.sent_at.strftime("%b %d, %Y %H:%M"),
        }
        return JsonResponse(response_data)

    return JsonResponse({"error": "Invalid message form"}, status=400)

### USER CHATS WITH ADMIN ###
@login_required
def chat_with_admin(request):
    """Regular user chats with the superuser (admin)."""
    if request.user.is_superuser:
        return redirect("communications:conversations")  # Admin should use chat_with_user

    superuser = User.objects.filter(is_superuser=True).first()
    if not superuser:
        return render(request, "communications/chat_messages.html", {"error": "No admin available"})

    conversation, created = Conversation.objects.get_or_create(
        superuser=superuser,
        user=request.user
    )
    # Mark unread messages as read
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
    """Regular user sends a message to superuser (admin)."""
    conversation = get_object_or_404(Conversation, id=conversation_id)
    form = ChatMessageForm(request.POST)

    if form.is_valid():
        # Create the new message
        message = ChatMessage.objects.create(
            conversation=conversation,
            sender=request.user,  # Regular user is the sender
            receiver=conversation.superuser,  # Superuser is the receiver
            content=form.cleaned_data["content"]
        )

        # Prepare the response data
        response_data = {
            'sender': message.sender.username,
            'message': message.content,
            'sent_at': message.sent_at.strftime('%H:%M'),  # Format the time to display in "H:i"
            'is_read': message.is_read,  # Show the read status
        }

        return JsonResponse(response_data)

    # If form is not valid, return an error response
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
    """Fetch users based on search query for admin."""
    query = request.GET.get("q", "").strip()
    if not query:
        return JsonResponse([], safe=False)

    users = User.objects.filter(Q(username__icontains=query))[:10]
    data = [{"id": user.id, "username": user.username} for user in users]

    return JsonResponse(data, safe=False)