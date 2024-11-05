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

