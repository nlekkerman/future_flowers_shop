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
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request):
        user = request.user
        if user.is_superuser:
            # Admin sees all new messages
            count = ChatMessage.objects.filter(seen=False).count()
        else:
            # Regular user sees only their related messages
            count = ChatMessage.objects.filter(
                conversation__user=user,
                seen=False
            ).count()

        return Response({'count': count})

        
@require_POST
@login_required
def mark_as_seen(request):
    conversation_id = request.POST.get('conversation_id')
    conversation = get_object_or_404(ChatConversation, id=conversation_id)
    
    # Mark all unseen messages as seen
    ChatMessage.objects.filter(conversation=conversation, seen=False).update(seen=True)
    
    return JsonResponse({'success': True})

@login_required
def user_chat_messages(request):
    conversation = ChatConversation.objects.filter(
        user=request.user, superuser__is_superuser=True
    ).first()

    if not conversation:
        superuser = get_object_or_404(User, is_superuser=True)
        conversation = ChatConversation.objects.create(
            user=request.user,
            superuser=superuser
        )

    messages = ChatMessage.objects.filter(conversation=conversation).order_by('sent_at')

    if request.method == 'POST':
        form = ChatMessageForm(request.POST, user=request.user, superuser=conversation.superuser)
        if form.is_valid():
            new_message = form.save(commit=False)
            new_message.conversation = conversation
            new_message.sender = request.user
            new_message.save()
            return JsonResponse({'success': True, 'message': new_message.message, 'sender': new_message.sender.username})
        else:
            return JsonResponse({'success': False, 'errors': form.errors})
    else:
        form = ChatMessageForm(user=request.user, superuser=conversation.superuser)

    return JsonResponse({
        'messages': list(messages.values('message', 'sender__username', 'sent_at')),
        'form': form.as_p()
    })

@login_required
def admin_user_chat_messages(request, conversation_id):
    if not request.user.is_superuser:
        return JsonResponse({'success': False, 'error': 'Not authorized'}, status=403)

    conversation = get_object_or_404(ChatConversation, id=conversation_id, superuser=request.user)
    messages = ChatMessage.objects.filter(conversation=conversation).order_by('sent_at')

    if request.method == 'POST':
        form = ChatMessageForm(request.POST, user=request.user, superuser=conversation.superuser)
        if form.is_valid():
            new_message = form.save(commit=False)
            new_message.conversation = conversation
            new_message.sender = request.user
            new_message.save()
            return JsonResponse({'success': True, 'message': new_message.message, 'sender': new_message.sender.username})
        else:
            return JsonResponse({'success': False, 'errors': form.errors})
    else:
        form = ChatMessageForm(user=request.user, superuser=conversation.superuser)

    return JsonResponse({
        'messages': list(messages.values('message', 'sender__username', 'sent_at')),
        'form': form.as_p()
    })


def contact_view(request):
    return render(request, 'communications/contact.html')

def about(request):
    return render(request, 'communications/about.html')

def faq_view(request):
    # Updated FAQs (Static Content)
    faqs = [
        {
            "question": "What is the delivery policy?",
            "answer": "Delivery is free for orders above $50. For orders under $50, a small shipping fee applies."
        },
        {
            "question": "How should I store my seeds?",
            "answer": "Seeds should be stored in a cool, dry place, away from sunlight to maintain their viability."
        },
        {
            "question": "Can I return seeds?",
            "answer": "We accept returns for unopened seed packets within 30 days of purchase."
        },
        {
            "question": "How do I plant my seeds?",
            "answer": "Each seed comes with specific planting instructions on the packet. Generally, plant them in well-drained soil and ensure they receive adequate sunlight."
        },
        {
            "question": "Are the seeds GMO-free?",
            "answer": "Yes, all our seeds are free from genetic modifications and are naturally grown."
        },
        {
            "question": "How long do the seeds stay viable?",
            "answer": "Seeds can stay viable for 1-3 years if stored properly, but it’s best to plant them within the first year."
        },
        {
            "question": "What is the best season to plant seeds?",
            "answer": "It depends on the type of plant, but most seeds are best planted in the spring or early summer."
        },
        {
            "question": "Do you offer international shipping?",
            "answer": "Currently, we only offer shipping within the United States. We hope to expand internationally in the future."
        },
        {
            "question": "Can I buy seeds in bulk?",
            "answer": "Yes, we offer bulk discounts for large orders. Contact us for more information on bulk pricing."
        }
    ]

    return render(request, 'communications/questions.html', {'faqs': faqs})

