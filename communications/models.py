from django.contrib.auth.models import User
from django.db import models

class Conversation(models.Model):
    """ Represents a chat between a user and the superuser """
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="conversations")
    superuser = models.ForeignKey(
        User, on_delete=models.CASCADE, related_name="superuser_conversations",
        limit_choices_to={"is_superuser": True}
    )
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Conversation between {self.user} and {self.superuser}"

class ChatMessage(models.Model):
    """ Stores messages within a conversation """
    conversation = models.ForeignKey(Conversation, on_delete=models.CASCADE, related_name="messages")
    sender = models.ForeignKey(User, on_delete=models.CASCADE, related_name="sent_messages")
    receiver = models.ForeignKey(User, on_delete=models.CASCADE, related_name="received_messages")
    
    content = models.TextField()
    sent_at = models.DateTimeField(auto_now_add=True)
    is_read = models.BooleanField(default=False)
    is_deleted = models.BooleanField(default=False)  # Soft delete, so we keep records

    def __str__(self):
        return f"Message from {self.sender} to {self.receiver} at {self.sent_at}"
