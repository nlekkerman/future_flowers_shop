# communications/context_processors.py

from .models import ChatMessage

def unread_messages(request):
    """ Adds unread message count to the context globally """
    unread_count = 0
    if request.user.is_authenticated:
        unread_count = ChatMessage.objects.filter(
            receiver=request.user, is_read=False, is_deleted=False
        ).count()
    return {'unread_messages_count': unread_count}
