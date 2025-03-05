from django.contrib.auth.models import User
from django.db import models

"""
Django models for handling conversations and chat messages.

1. **Conversation Model**:
   - Represents a chat session between a user and a superuser.
   - Contains a foreign key to the `User` model to represent both the user and the superuser.
   - Tracks the creation date of the conversation using `created_at`.

2. **ChatMessage Model**:
   - Represents individual messages within a conversation.
   - Contains foreign keys to the `Conversation` and `User` models to establish relationships with the conversation and the sender/receiver.
   - Stores message content, the time it was sent, and flags to mark whether the message has been read (`is_read`) or deleted (`is_deleted`).
   - Supports a soft delete mechanism by marking the message as deleted instead of removing it from the database.

The `Conversation` and `ChatMessage` models help structure and store chat data, enabling the creation of a conversation history with support for user interaction and message management (e.g., read/unread, deletion).
"""

class Conversation(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="conversations")
    superuser = models.ForeignKey(
        User, on_delete=models.CASCADE, related_name="superuser_conversations",
        limit_choices_to={"is_superuser": True}
    )
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Conversation between {self.user} and {self.superuser}"

class ChatMessage(models.Model):
    conversation = models.ForeignKey(Conversation, on_delete=models.CASCADE, related_name="messages")
    sender = models.ForeignKey(User, on_delete=models.CASCADE, related_name="sent_messages")
    receiver = models.ForeignKey(User, on_delete=models.CASCADE, related_name="received_messages")
    
    content = models.TextField()
    sent_at = models.DateTimeField(auto_now_add=True)
    is_read = models.BooleanField(default=False)
    is_deleted = models.BooleanField(default=False)

    def __str__(self):
        return f"Message from {self.sender} to {self.receiver} at {self.sent_at}"
