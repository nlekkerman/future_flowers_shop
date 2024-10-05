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

@login_required
def chat_bot_handle_choice(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        choice = data.get('choice')

        if choice == '1':
            chat_messages = '<div class="message bot"><p>Here are some options about seeds:</p></div>'
            chat_options = '''
                <button type="button" class="btn" onclick="handleChoice('1.1')">Check out our Q&A page</button>
                <button type="button" class="btn" onclick="handleChoice('1.2')">Chat with us</button>
            '''
        elif choice == '2':
            chat_messages = '<div class="message bot"><p>Here are some options about delivery:</p></div>'
            chat_options = '''
                <button type="button" class="btn" onclick="handleChoice('2.1')">Check out our Q&A page</button>
                <button type="button" class="btn" onclick="handleChoice('2.2')">Chat with us</button>
            '''
        elif choice == '1.1' or choice == '2.1':
            chat_messages = '<div class="message bot"><p>Redirecting to our Q&A page...</p></div>'
            chat_options = ''
            redirect_url = reverse('communications:qa_page')
            return JsonResponse({'redirect_url': redirect_url})
        elif choice == '1.2' or choice == '2.2':
            redirect_url = reverse('communications:user_chat_messages') if not request.user.is_superuser else reverse('communications:chat_list')
            return JsonResponse({'redirect_url': redirect_url})
        else:
            chat_messages = '<div class="message bot"><p>Invalid choice, please select again.</p></div>'
            chat_options = '''
                <button type="button" class="btn" onclick="handleChoice('1')">Do you have a question about seeds?</button>
                <button type="button" class="btn" onclick="handleChoice('2')">Do you have a question about delivery?</button>
                <button type="button" class="btn" onclick="handleChoice('3')">Do you want to chat with us?</button>
            '''

        return JsonResponse({
            'chat_messages': chat_messages,
            'chat_options': chat_options
        })

@login_required
def chat_bot_view(request):
    initial_message = "Hi, I'm Buzz, your chatbot. How can I assist you today?"
    choices = [
        {"value": "1", "text": "Do you have a question about seeds?"},
        {"value": "2", "text": "Do you have a question about delivery?"},
        {"value": "3", "text": "Do you want to chat with us?"}
    ]
    
    return render(request, 'communications/chat_bot.html', {
        'initial_message': initial_message,
        'choices': choices
    })

def contact_view(request):
    return render(request, 'communications/contact.html')

def about(request):
    return render(request, 'communications/about.html')

