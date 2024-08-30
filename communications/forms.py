from django import forms
from .models import ChatMessage, ChatConversation

class ChatMessageForm(forms.ModelForm):
    class Meta:
        model = ChatMessage
        fields = ['content']
        widgets = {
            'content': forms.Textarea(attrs={
                'placeholder': 'Type your message here...',  # Optional: add a placeholder
                'rows': 1,  # Start with just one row
                'style': 'width: 100%;',  
            }),
        }

    def __init__(self, *args, **kwargs):
        self.user = kwargs.pop('user', None)
        self.superuser = kwargs.pop('superuser', None)
        super().__init__(*args, **kwargs)
        # Remove the label by setting it to an empty string
        self.fields['content'].label = ''

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
