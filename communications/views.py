import json
from rest_framework import permissions
from rest_framework.response import Response
from rest_framework.views import APIView
from django.shortcuts import render, redirect, get_object_or_404
from django.http import JsonResponse
from django.contrib.auth.decorators import login_required
from django.views.decorators.http import require_POST
from django.urls import reverse
from .models import ChatConversation, ChatMessage
from .forms import ChatMessageForm
from django.contrib.auth.models import User


class NewMessagesCountAPIView(APIView):
    """
    Returns the count of new unread messages for the authenticated user.

    This API view counts the number of new (unseen) messages in a user's
    conversations.
    - Admin users (superusers) will see the count
    of all new messages across all conversations.
    - Regular users will only see the count of new
    messages in conversations they are part of,
    filtered by whether the messages
    are marked as seen or unseen.

    The count is useful to update the UI with the number of unread
    messages in a chat interface.

    Parameters:
        - request (HttpRequest): The HTTP request object containing
        the authenticated user.

    Returns:
        JsonResponse: A response with a JSON object containing the
        count of new unread messages.
    """

    permission_classes = [permissions.IsAuthenticated]

    def get(self, request):
        user = request.user
        if user.is_superuser:
            count = ChatMessage.objects.filter(seen=False).count()
        else:
            count = ChatMessage.objects.filter(
                conversation__user=user, seen=False
            ).count()
        return Response({"count": count})


@require_POST
@login_required
def mark_as_seen(request):
    """
    Marks all unseen messages in a specific conversation as seen.

    This view allows a user to mark all unread (unseen)
    messages in a given conversation as seen.
    The view expects a POST request with the conversation ID.
    All messages related to that
    conversation and marked as unseen will be updated to seen status.

    Parameters:
        - request (HttpRequest): The HTTP request containing
        the conversation ID as POST data.

    Returns:
        JsonResponse: A response indicating success
        or failure of the operation. If successful,
                      it returns a JSON object with
                      a 'success' key set to True.
    """
    conversation_id = request.POST.get("conversation_id")
    conversation = get_object_or_404(ChatConversation, id=conversation_id)

    # Mark all unseen messages as seen

    ChatMessage.objects.filter(conversation=conversation, seen=False).update(
        seen=True
    )

    return JsonResponse({"success": True})


@login_required
def user_chat_messages(request):
    """
    Retrieves and handles chat messages for the logged-in user.

    This view checks if the user has an existing conversation
    with an admin. If not, it creates a
    new conversation. It allows the user to send new messages
    and also displays the existing chat
    messages in the conversation. The chat messages are
    returned along with an HTML form for sending
    new messages.

    Parameters:
        - request (HttpRequest): The HTTP request containing
        the current user's details and message data.

    Returns:
        JsonResponse: A response containing a list of chat messages
        in the conversation and the HTML
                      form for sending a new message. The messages
                      are returned as a list of dictionaries
                      containing the message text, sender, and timestamp.
    """
    conversation = ChatConversation.objects.filter(
        user=request.user, superuser__is_superuser=True
    ).first()

    if not conversation:
        superuser = get_object_or_404(User, is_superuser=True)
        conversation = ChatConversation.objects.create(
            user=request.user, superuser=superuser
        )
    messages = ChatMessage.objects.filter(conversation=conversation).order_by(
        "sent_at"
    )

    if request.method == "POST":
        form = ChatMessageForm(
            request.POST,
            user=request.user,
            superuser=conversation.superuser,
        )
        if form.is_valid():
            new_message = form.save(commit=False)
            new_message.conversation = conversation
            new_message.sender = request.user
            new_message.save()
            return JsonResponse(
                {
                    "success": True,
                    "message": new_message.message,
                    "sender": new_message.sender.username,
                }
            )
        else:
            return JsonResponse({"success": False, "errors": form.errors})
    else:
        form = ChatMessageForm(
            user=request.user, superuser=conversation.superuser
        )
    return JsonResponse(
        {
            "messages": list(
                messages.values("message", "sender__username", "sent_at")
            ),
            "form": form.as_p(),
        }
    )


@login_required
def admin_user_chat_messages(request, conversation_id):
    """
    Retrieves and handles chat messages for an admin
    user in a specific conversation.

    This view is similar to `user_chat_messages`,
    but intended for the admin user (superuser).
    The admin can view the messages in a given conversation,
    send new messages, and see all existing
    messages in that conversation.
    Only superusers are authorized to access this view.

    Parameters:
        - request (HttpRequest): The HTTP request containing
        the admin user's details and message data.
        - conversation_id (int): The ID of the conversation
        for which messages need to be retrieved.

    Returns:
        JsonResponse: A response containing a list of chat
        messages in the conversation and the HTML
                      form for sending a new message.
                      The messages are returned as a list of dictionaries
                      containing the message text, sender, and timestamp.
    """
    if not request.user.is_superuser:
        return JsonResponse(
            {"success": False, "error": "Not authorized"}, status=403
        )
    conversation = get_object_or_404(
        ChatConversation, id=conversation_id, superuser=request.user
    )
    messages = ChatMessage.objects.filter(conversation=conversation).order_by(
        "sent_at"
    )

    if request.method == "POST":
        form = ChatMessageForm(
            request.POST,
            user=request.user,
            superuser=conversation.superuser,
        )
        if form.is_valid():
            new_message = form.save(commit=False)
            new_message.conversation = conversation
            new_message.sender = request.user
            new_message.save()
            return JsonResponse(
                {
                    "success": True,
                    "message": new_message.message,
                    "sender": new_message.sender.username,
                }
            )
        else:
            return JsonResponse({"success": False, "errors": form.errors})
    else:
        form = ChatMessageForm(
            user=request.user, superuser=conversation.superuser
        )
    return JsonResponse(
        {
            "messages": list(
                messages.values("message", "sender__username", "sent_at")
            ),
            "form": form.as_p(),
        }
    )


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
