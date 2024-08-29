from django.contrib import admin
from django.utils import timezone
from .models import ChatConversation, ChatMessage  # Updated import

class ChatConversationAdmin(admin.ModelAdmin):
    list_display = ('user', 'superuser', 'started_at', 'is_active')
    list_filter = ('is_active', 'started_at')
    search_fields = ('user__username', 'superuser__username')
    readonly_fields = ('started_at', 'created_at', 'updated_at')

    def get_queryset(self, request):
        qs = super().get_queryset(request)
        if request.user.is_superuser:
            return qs
        return qs.filter(user=request.user)  # or any other condition based on your requirements

    def save_model(self, request, obj, form, change):
        if not change:  # Only set 'started_at' when creating a new instance
            obj.started_at = timezone.now()
        super().save_model(request, obj, form, change)

class ChatMessageAdmin(admin.ModelAdmin):  # Updated class name
    list_display = ('conversation', 'sender', 'sent_at', 'received_at', 'seen')
    list_filter = ('seen', 'sent_at')
    search_fields = ('conversation__id', 'sender__username', 'content')
    readonly_fields = ('sent_at', 'received_at', 'created_at', 'updated_at')

    def get_queryset(self, request):
        qs = super().get_queryset(request)
        if request.user.is_superuser:
            return qs
        return qs.filter(conversation__user=request.user)  # Adjust based on your logic

    def save_model(self, request, obj, form, change):
        if not change:  # Set 'sent_at' when creating a new instance
            obj.sent_at = timezone.now()
        super().save_model(request, obj, form, change)

# Register the updated models
admin.site.register(ChatConversation, ChatConversationAdmin)
admin.site.register(ChatMessage, ChatMessageAdmin)  # Updated model name
