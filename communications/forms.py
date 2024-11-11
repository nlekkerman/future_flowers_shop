from django import forms
from .models import ChatMessage, ChatConversation

class ChatMessageForm(forms.ModelForm):
    """
    A form to handle chat messages. This form allows users to send messages 
    within a conversation, either as a user or as a superuser (admin).

    Attributes:
        - content (forms.Textarea): A text area for the message content.

    Methods:
        - __init__(self): Customizes the form by removing labels and accepting user and superuser arguments.
        - save(self, commit=True): Saves the chat message with the correct sender and conversation.
    """
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
        """
        Initializes the form with user and superuser attributes and removes the content label.

        Parameters:
            - user (User): The user sending the message.
            - superuser (User): The superuser involved in the conversation.
        """
        self.user = kwargs.pop('user', None)
        self.superuser = kwargs.pop('superuser', None)
        super().__init__(*args, **kwargs)
        # Remove the label by setting it to an empty string
        self.fields['content'].label = ''

    def save(self, commit=True):
        """
        Saves the chat message, associates it with a conversation, and sets the sender.

        Parameters:
            - commit (bool): Whether to save the instance to the database (default is True).
        
        Returns:
            message (ChatMessage): The saved chat message instance.
        """
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
