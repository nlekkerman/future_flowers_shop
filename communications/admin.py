from django.contrib import admin
from .models import Conversation, ChatMessage

class MessageInline(admin.TabularInline):
    model = ChatMessage
    extra = 0  # No empty forms for new messages

class ConversationAdmin(admin.ModelAdmin):
    list_display = ('user', 'superuser', 'created_at')
    search_fields = ('user__username', 'superuser__username')
    inlines = [MessageInline]  # Inline Message display within Conversation view

    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        if request.user.is_superuser:
            return queryset  # Superusers can see all conversations
        else:
            return queryset.filter(user=request.user)  # Normal users can see only their conversations

class ChatMessageAdmin(admin.ModelAdmin):
    list_display = ('sender', 'receiver', 'content', 'sent_at', 'is_read', 'is_deleted')
    list_filter = ('is_read', 'is_deleted')
    search_fields = ('sender__username', 'receiver__username', 'content')
    actions = ['mark_as_read', 'delete_selected_messages']

    # Action to mark selected messages as read
    def mark_as_read(self, request, queryset):
        updated = queryset.update(is_read=True)
        self.message_user(request, f"{updated} message(s) marked as read.")
    mark_as_read.short_description = "Mark selected messages as read"

    # Action to delete selected messages (soft delete)
    def delete_selected_messages(self, request, queryset):
        updated = queryset.update(is_deleted=True)
        self.message_user(request, f"{updated} message(s) marked as deleted (soft delete).")
    delete_selected_messages.short_description = "Soft delete selected messages"

admin.site.register(Conversation, ConversationAdmin)
admin.site.register(ChatMessage, ChatMessageAdmin)
