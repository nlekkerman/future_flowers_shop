from .models import ChatConversation, ChatMessage

def chat_context(request):
    """
    Generates the context for chat-related views, including fetching conversations and messages.

    This function retrieves all chat conversations involving the logged-in user (either as a regular user or superuser).
    If a specific conversation ID is provided in the request, it fetches the details of that conversation along with its
    associated messages. If the conversation is not found, an error message is added to the context.

    Parameters:
        - request (HttpRequest): The HTTP request, which may contain the logged-in user and an optional conversation_id.

    Returns:
        dict: A dictionary containing the following context data:
            - 'conversations': A queryset of all conversations involving the logged-in user.
            - 'specific_conversation': The conversation details for a specific conversation ID (if found).
            - 'messages': A queryset of messages associated with the specific conversation (if found).
            - 'error': An error message if the specified conversation ID is not valid.
    """
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
