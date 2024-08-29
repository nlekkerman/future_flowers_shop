from django import forms
from .models import ChatMessage, ChatConversation

class ChatMessageForm(forms.ModelForm):  # Form name updated to ChatMessageForm
    class Meta:
        model = ChatMessage
        fields = ['content']

    def __init__(self, *args, **kwargs):
        self.user = kwargs.pop('user', None)
        self.superuser = kwargs.pop('superuser', None)
        super().__init__(*args, **kwargs)

    def save(self, commit=True):
        message = super().save(commit=False)
        if commit:
            message.sender = self.user
            # Retrieve or create the conversation
            conversation, created = ChatConversation.objects.get_or_create(
                user=self.user,
                superuser=self.superuser
            )
            message.conversation = conversation
            message.save()
        return message
