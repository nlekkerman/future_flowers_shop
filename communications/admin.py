from django.contrib import admin
from .models import Conversation, ChatMessage


"""
Django Admin Configuration for Conversations and Chat Messages

This file contains the Django Admin configuration for managing 'Conversation' and 'ChatMessage' models within the admin interface. The goal is to allow administrators and superusers to effectively manage and monitor user conversations and individual chat messages.

- **MessageInline**: This class enables the display of related `ChatMessage` instances inline within the `Conversation` model’s admin interface. 
    - `extra = 0` means that no empty forms will be shown for adding new messages directly within the conversation view.
    
- **ConversationAdmin**: This is the admin configuration for the `Conversation` model, which represents a conversation between a user and a superuser/admin.
    - `list_display`: This controls which fields are displayed in the admin list view. Here it shows the user, the superuser involved, and the creation date of the conversation.
    - `search_fields`: This adds search functionality, allowing admins to search conversations by the usernames of the user or superuser.
    - `inlines`: By including `MessageInline`, this allows the admin interface for `Conversation` to also show all related messages (`ChatMessage`) inline under each conversation. It makes it easy for admins to view and interact with messages directly.
    - `get_queryset`: This method customizes the queryset shown in the admin interface. Superusers can see all conversations, while normal users are restricted to viewing only their own conversations. This ensures privacy and security by limiting access to sensitive data.

- **ChatMessageAdmin**: This class configures the admin interface for the `ChatMessage` model, which represents individual messages in a conversation.
    - `list_display`: Displays key fields such as the sender, receiver, content, time sent, read status, and deleted status in the list view.
    - `list_filter`: Adds filters for easy sorting of messages based on their read and deleted status. This helps admins quickly find unread or deleted messages.
    - `search_fields`: Enables admins to search messages by sender, receiver, or message content.
    - `actions`: Custom actions are defined to allow admins to mark messages as read or soft delete selected messages.
        - `mark_as_read`: Marks selected messages as read and provides feedback to the admin on how many messages were updated.
        - `delete_selected_messages`: Soft deletes (marks as deleted without removing from the database) selected messages, again providing feedback on how many messages were updated.
    
This code provides an efficient and secure way to manage and interact with conversations and messages within the Django Admin panel, giving admins control over who can see which data and what actions they can take.
"""

class MessageInline(admin.TabularInline):
    model = ChatMessage
    extra = 0


class ConversationAdmin(admin.ModelAdmin):
    list_display = ('user', 'superuser', 'created_at')
    search_fields = ('user__username', 'superuser__username')
    inlines = [MessageInline]

    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        if request.user.is_superuser:
            return queryset
        else:
            return queryset.filter(user=request.user)


class ChatMessageAdmin(admin.ModelAdmin):
    list_display = ('sender', 'receiver', 'content', 'sent_at', 'is_read', 'is_deleted')
    list_filter = ('is_read', 'is_deleted')
    search_fields = ('sender__username', 'receiver__username', 'content')
    actions = ['mark_as_read', 'delete_selected_messages']

    def mark_as_read(self, request, queryset):
        updated = queryset.update(is_read=True)
        self.message_user(request, f"{updated} message(s) marked as read.")
    mark_as_read.short_description = "Mark selected messages as read"

    def delete_selected_messages(self, request, queryset):
        updated = queryset.update(is_deleted=True)
        self.message_user(request, f"{updated} message(s) marked as deleted (soft delete).")
    delete_selected_messages.short_description = "Soft delete selected messages"



admin.site.register(Conversation, ConversationAdmin)
admin.site.register(ChatMessage, ChatMessageAdmin)


