from django.db import models
from django.conf import settings
from django.utils import timezone

class ChatConversation(models.Model):
    """
    Represents a conversation between a user and a superuser.

    A `ChatConversation` model is used to store the metadata related to each conversation.
    Each conversation involves a user and a superuser (admin), and it tracks when the conversation 
    started, whether it is still active, and whether it has been deleted.

    Attributes:
        - user (ForeignKey): The user who initiated the conversation.
        - superuser (ForeignKey): The superuser (admin) who is part of the conversation.
        - started_at (DateTimeField): The timestamp when the conversation started.
        - is_active (BooleanField): A flag to indicate whether the conversation is still active.
        - created_at (DateTimeField): The timestamp when the conversation was created.
        - updated_at (DateTimeField): The timestamp when the conversation was last updated.
        - last_modified (DateTimeField): The timestamp of the most recent change to the conversation.
        - deleted (BooleanField): A flag to indicate whether the conversation has been deleted.

    Methods:
        - get_unseen_messages_count(user): Returns the count of unseen messages for the given user in this conversation.
    """
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='user_conversations')
    superuser = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='superuser_conversations')
    started_at = models.DateTimeField(default=timezone.now)
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    last_modified = models.DateTimeField(auto_now=True)
    deleted = models.BooleanField(default=False)

    class Meta:
        indexes = [
            models.Index(fields=['user', 'superuser']),
            models.Index(fields=['started_at']),
        ]

    def __str__(self):
        """
        String representation of the conversation model.
        
        Provides a user-friendly representation of the conversation,
        showing the participants (user and superuser) and the start time.

        Returns:
            str: A string representation of the conversation.
        """
        return f"Conversation between {self.user} and {self.superuser} started at {self.started_at}"
        
        # New method to get unseen messages count
    def get_unseen_messages_count(self, user):
        """
        Returns the number of unseen messages for the given user in this conversation.

        This method calculates how many messages in the conversation have not been seen 
        by the specified user. It filters out messages that were sent by the user, as they 
        are not considered as unseen for that user.

        Parameters:
            - user (User): The user whose unseen messages are being counted.

        Returns:
            int: The count of unseen messages for the given user in this conversation.
        """
        return self.messages.filter(seen=False).exclude(sender=user).count()

class ChatMessage(models.Model):
    """
    Represents a message within a `ChatConversation`.

    A `ChatMessage` model is used to store each individual message in a conversation. It tracks the 
    sender, content, and timestamps related to the message. The `seen` field indicates whether the 
    message has been viewed by the recipient, and the `deleted` field flags whether the message has 
    been removed.

    Attributes:
        - conversation (ForeignKey): The conversation that this message is part of.
        - sender (ForeignKey): The user who sent the message.
        - content (TextField): The text content of the message.
        - sent_at (DateTimeField): The timestamp when the message was sent.
        - received_at (DateTimeField): The timestamp when the message was received (optional).
        - seen (BooleanField): A flag to indicate whether the message has been seen by the recipient.
        - created_at (DateTimeField): The timestamp when the message was created.
        - updated_at (DateTimeField): The timestamp when the message was last updated.
        - last_modified (DateTimeField): The timestamp of the most recent change to the message.
        - deleted (BooleanField): A flag to indicate whether the message has been deleted.

    Methods:
        - __str__(): Provides a string representation of the message, showing the sender and sent time.
    """
    conversation = models.ForeignKey(ChatConversation, on_delete=models.CASCADE, related_name='messages')
    sender = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    content = models.TextField()
    sent_at = models.DateTimeField(default=timezone.now)
    received_at = models.DateTimeField(null=True, blank=True)
    seen = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    last_modified = models.DateTimeField(auto_now=True)
    deleted = models.BooleanField(default=False)

    class Meta:
        ordering = ['sent_at']
        indexes = [
            models.Index(fields=['conversation']),
            models.Index(fields=['sender']),
        ]

    def __str__(self):
        """
        String representation of the message model.

        Provides a user-friendly representation of the message, showing the sender and the 
        timestamp when the message was sent.

        Returns:
            str: A string representation of the message.
        """
        return f"Message from {self.sender} at {self.sent_at}"
