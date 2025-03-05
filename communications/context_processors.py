from .models import ChatMessage

"""
Unread Messages Count Context Processor

This function adds the count of unread messages for the currently authenticated user to the global context. It checks for messages sent to the user that are both unread (`is_read=False`) and not deleted (`is_deleted=False`).

### Key Points:
1. **Authentication Check**: It first ensures the user is logged in.
2. **Unread Count**: It queries the `ChatMessage` model to count unread, non-deleted messages for the authenticated user.
3. **Context Injection**: The unread count is added to the context with the key `'unread_messages_count'`, making it available in all templates.

### Usage:
This count can be used to display the number of unread messages, for example, next to a messaging icon on every page.
"""


def unread_messages(request):
    """ Adds unread message count to the context globally """
    unread_count = 0
    if request.user.is_authenticated:
        unread_count = ChatMessage.objects.filter(
            receiver=request.user, is_read=False, is_deleted=False
        ).count()
    return {'unread_messages_count': unread_count}
