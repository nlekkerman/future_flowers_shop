from django import forms
from .models import ChatMessage, Conversation
from django import forms
from .models import ChatMessage


"""
Form for submitting a chat message.

This form is based on the `ChatMessage` model and allows users to submit content for their messages. The form
applies specific attributes to the 'content' field to enhance the user experience and apply Bootstrap styling.

- Updates the 'content' field:
  1. **class**: Adds `'form-control'` to ensure the input field uses Bootstrap's styling.
  2. **placeholder**: Sets a placeholder text of `'Type your message...'` to guide the user on what to enter.

These changes ensure consistency in the UI and a more user-friendly experience when submitting messages.

Fields:
- `content`: The text content of the message.
"""

class ChatMessageForm(forms.ModelForm):
    class Meta:
        model = ChatMessage
        fields = ['content']

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['content'].widget.attrs.update({'class': 'form-control', 'placeholder': 'Type your message...'})
