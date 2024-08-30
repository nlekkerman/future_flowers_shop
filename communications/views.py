import json
from django.shortcuts import render, redirect, get_object_or_404
from django.http import JsonResponse
from django.contrib.auth.decorators import login_required
from django.urls import reverse
from .models import ChatConversation, ChatMessage
from .forms import ChatMessageForm 
from django.contrib.auth.models import User



def conversation_detail(request, pk):
    conversation = get_object_or_404(ChatConversation, pk=pk)
    messages = ChatMessage.objects.filter(conversation=conversation).order_by('sent_at')
    return render(request, 'communications/_chat_messages.html', {
        'conversation': conversation,
        'messages': messages
    })


@login_required
def chat_list(request):
    if request.user.is_superuser:
        # Fetch all conversations for superuser
        conversations = ChatConversation.objects.all()

        # Get the latest message for each conversation
        for conversation in conversations:
            latest_message = ChatMessage.objects.filter(
                conversation=conversation
            ).order_by('-sent_at').first()
            conversation.latest_message = latest_message

        return render(request, 'communications/chat.html', {'conversations': conversations})
    else:
        # Redirect to user chat messages
        # Ensure `some_id` is determined appropriately
        return redirect('communications:user_chat_messages', conversation_id=some_id)


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


@login_required
def admin_user_chat_messages(request, conversation_id):
    # Ensure the user is an admin
    if not request.user.is_superuser:
        return redirect('communications:chat_list')  # Redirect if not an admin

    # Retrieve the conversation based on ID
    conversation = get_object_or_404(ChatConversation, id=conversation_id, superuser=request.user)

    # Fetch messages related to the conversation
    messages = ChatMessage.objects.filter(conversation=conversation).order_by('sent_at')

    # Handle form for new messages
    if request.method == 'POST':
        form = ChatMessageForm(request.POST, user=request.user, superuser=conversation.superuser)
        if form.is_valid():
            new_message = form.save(commit=False)
            new_message.conversation = conversation
            new_message.sender = request.user  # Set the sender here
            new_message.save()
            return redirect('communications:admin_user_chat_messages', conversation_id=conversation_id)  # Refresh to show the new message
    else:
        form = ChatMessageForm(user=request.user, superuser=conversation.superuser)

    return render(request, 'communications/_chat_messages.html', {
        'conversation': conversation,
        'chat_messages': messages,
        'form': form
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
        elif choice == '1.1':
            chat_messages = '<div class="message bot"><p>Redirecting to our Q&A page...</p></div>'
            chat_options = ''  # No further options
            redirect_url = reverse('communications:qa_page')
            return JsonResponse({'redirect_url': redirect_url})
        elif choice == '1.2' or choice == '2.2':
            # Redirect to user chat messages
            if request.user.is_superuser:
                redirect_url = reverse('communications:chat_list')
            else:
                redirect_url = reverse('communications:user_chat_messages')
            return JsonResponse({'redirect_url': redirect_url})
        elif choice == '2.1':
            chat_messages = '<div class="message bot"><p>Redirecting to our Q&A page...</p></div>'
            chat_options = ''  # No further options
            redirect_url = reverse('communications:qa_page')
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
    # Initial setup
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