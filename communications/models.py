from django.db import models
from django.conf import settings
from django.utils import timezone

class ChatConversation(models.Model):
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
        return f"Conversation between {self.user} and {self.superuser} started at {self.started_at}"

class ChatMessage(models.Model):
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
        return f"Message from {self.sender} at {self.sent_at}"
