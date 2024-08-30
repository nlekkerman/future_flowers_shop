# communications/views.py
from django.shortcuts import render, redirect, get_object_or_404
from .models import ChatConversation, ChatMessage
from .forms import ChatMessageForm 
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
def chat_list(request):
    conversations = ChatConversation.objects.all()  # Retrieve all ChatConversation instances
    return render(request, 'communications/chat.html', {'conversations': conversations})



def conversation_detail(request, pk):
    conversation = get_object_or_404(ChatConversation, pk=pk)
    messages = ChatMessage.objects.filter(conversation=conversation).order_by('sent_at')
    return render(request, 'communications/conversation_detail.html', {
        'conversation': conversation,
        'messages': messages
    })


@login_required
def chat_list(request):
    # Superuser chat list logic
    if request.user.is_superuser:
        conversations = ChatConversation.objects.all()
        return render(request, 'communications/chat.html', {'conversations': conversations})
    else:
        return redirect('communications:user_chat_messages', conversation_id=some_id)  # Replace 'some_id' with actual logic

@login_required
def user_chat_messages(request):
    # Find the conversation involving the logged-in user and a superuser
    conversation = ChatConversation.objects.filter(
        user=request.user, superuser__is_superuser=True
    ).first()

    if not conversation:
        # If no conversation exists, create one with the superuser
        superuser = get_object_or_404(User, is_superuser=True)
        conversation = ChatConversation.objects.create(
            user=request.user,
            superuser=superuser
        )

    # Fetch messages related to the conversation
    messages = ChatMessage.objects.filter(
        conversation=conversation
    ).order_by('sent_at')

    # Handle form for new messages
    if request.method == 'POST':
        form = ChatMessageForm(request.POST, user=request.user, superuser=conversation.superuser)
        if form.is_valid():
            # Create and save the new message
            new_message = form.save(commit=False)
            new_message.conversation = conversation
            new_message.sender = request.user
            new_message.save()
            return redirect('communications:user_chat_messages')  # Refresh to show the new message
    else:
        form = ChatMessageForm(user=request.user, superuser=conversation.superuser)

    return render(request, 'communications/_chat_messages.html', {
        'conversation': conversation,
        'chat_messages': messages,
        'form': form
    })