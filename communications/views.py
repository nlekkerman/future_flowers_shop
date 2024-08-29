from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.utils import timezone
from .forms import ChatMessageForm
from django.http import JsonResponse

from .models import ChatConversation, ChatMessage

@login_required
def chat_view(request):
    superuser = request.user  # Assuming the current user is the superuser
    conversation, created = ChatConversation.objects.get_or_create(
        user=request.user,
        superuser=superuser,
        defaults={'started_at': timezone.now()}
    )
    
    if request.method == 'POST':
        form = ChatMessageForm(request.POST, user=request.user, superuser=superuser)
        if form.is_valid():
            form.save()
            if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
                chat_messages = ChatMessage.objects.filter(conversation=conversation)
                messages_data = [
                    {
                        'sender': message.sender.username,
                        'content': message.content,
                        'sent_at': message.sent_at.isoformat()
                    }
                    for message in chat_messages
                ]
                return JsonResponse({'messages': messages_data})
            messages.success(request, 'Your message has been sent.')
            return redirect('communications:chat_view')
    else:
        form = ChatMessageForm(user=request.user, superuser=superuser)
    
    chat_messages = ChatMessage.objects.filter(conversation=conversation)
    
    return render(request, 'communications/chat.html', {
        'form': form,
        'chat_messages': chat_messages,  # Updated variable name
        'superuser': superuser,
        'conversation': conversation
    })
