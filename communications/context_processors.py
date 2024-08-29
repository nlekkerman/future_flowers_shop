from .models import ChatConversation, ChatMessage

def chat_context(request):
    context = {}

    if request.user.is_authenticated:
        # Get all conversations involving the logged-in user
        conversations = ChatConversation.objects.filter(user=request.user) | ChatConversation.objects.filter(superuser=request.user)
        context['conversations'] = conversations

        # Fetch a specific conversation if `conversation_id` is provided in the request
        conversation_id = request.GET.get('conversation_id')
        if conversation_id:
            try:
                specific_conversation = conversations.get(id=conversation_id)
                context['specific_conversation'] = specific_conversation
                context['messages'] = Message.objects.filter(conversation=specific_conversation).order_by('sent_at')
            except ChatConversation.DoesNotExist:
                context['error'] = "Conversation not found."

    return context
