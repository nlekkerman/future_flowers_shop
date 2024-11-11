from django.contrib import admin
from django.utils import timezone
from .models import ChatConversation, ChatMessage  # Updated import

class ChatConversationAdmin(admin.ModelAdmin):
    """
    Admin interface for managing ChatConversation objects.

    This class customizes the display and behavior of ChatConversation models in the Django admin interface.
    - `list_display`: Specifies which fields to display in the list view.
    - `list_filter`: Adds filters to the right sidebar for filtering the list view.
    - `search_fields`: Allows searching by specific fields (e.g., usernames of user and superuser).
    - `readonly_fields`: Makes certain fields read-only in the admin interface.
    
    The `get_queryset` method restricts the visible conversations based on whether the user is an admin or a regular user. Admin users can see all conversations, while regular users can only see their own conversations.
    
    The `save_model` method customizes the saving behavior by setting the `started_at` timestamp when a new conversation is created.

    Attributes:
        - `list_display` (tuple): Specifies fields to display in the list view (user, superuser, started_at, is_active).
        - `list_filter` (tuple): Filters for `is_active` and `started_at` fields.
        - `search_fields` (tuple): Fields that can be searched (user's and superuser's usernames).
        - `readonly_fields` (tuple): Fields that cannot be edited (started_at, created_at, updated_at).
    """
    list_display = ('user', 'superuser', 'started_at', 'is_active')
    list_filter = ('is_active', 'started_at')
    search_fields = ('user__username', 'superuser__username')
    readonly_fields = ('started_at', 'created_at', 'updated_at')

    def get_queryset(self, request):
        """
        Filters the queryset based on whether the user is a superuser or a regular user.
        
        For superusers, all conversations are visible. For regular users, only their own conversations
        are displayed.

        Parameters:
            request (HttpRequest): The HTTP request object.

        Returns:
            queryset: A filtered queryset based on the user's permissions.
        """
        qs = super().get_queryset(request)
        if request.user.is_superuser:
            return qs
        return qs.filter(user=request.user)  # or any other condition based on your requirements

    def save_model(self, request, obj, form, change):
        """
        Custom save method to set the 'started_at' field when creating a new conversation.
        
        If the conversation is being created (not changed), set the 'started_at' timestamp to the current time.
        Then call the parent save_model method to persist the object.

        Parameters:
            request (HttpRequest): The HTTP request object.
            obj (ChatConversation): The instance of the model being saved.
            form (ModelForm): The form instance with the model data.
            change (bool): Indicates if the model is being updated or created.
        """
        if not change:  # Only set 'started_at' when creating a new instance
            obj.started_at = timezone.now()
        super().save_model(request, obj, form, change)

class ChatMessageAdmin(admin.ModelAdmin):
    """
    Admin interface for managing ChatMessage objects.

    This class customizes the display and behavior of ChatMessage models in the Django admin interface.
    - `list_display`: Specifies which fields to display in the list view.
    - `list_filter`: Adds filters for the `seen` and `sent_at` fields to filter messages by their visibility and time.
    - `search_fields`: Allows searching by conversation ID, sender's username, and message content.
    - `readonly_fields`: Makes certain fields read-only in the admin interface.

    The `get_queryset` method restricts the visible messages based on whether the user is an admin or a regular user. Admin users can see all messages, while regular users can only see messages from conversations they are involved in.

    The `save_model` method customizes the saving behavior by setting the `sent_at` timestamp when a new message is created.

    Attributes:
        - `list_display` (tuple): Specifies fields to display in the list view (conversation, sender, sent_at, received_at, seen).
        - `list_filter` (tuple): Filters for `seen` and `sent_at` fields.
        - `search_fields` (tuple): Fields that can be searched (conversation ID, sender's username, content).
        - `readonly_fields` (tuple): Fields that cannot be edited (sent_at, received_at, created_at, updated_at).
    """
    list_display = ('conversation', 'sender', 'sent_at', 'received_at', 'seen')
    list_filter = ('seen', 'sent_at')
    search_fields = ('conversation__id', 'sender__username', 'content')
    readonly_fields = ('sent_at', 'received_at', 'created_at', 'updated_at')

    def get_queryset(self, request):
        """
        Filters the queryset based on whether the user is a superuser or a regular user.
        
        For superusers, all messages are visible. For regular users, only messages from conversations
        they are involved in (as user or superuser) are visible.

        Parameters:
            request (HttpRequest): The HTTP request object.

        Returns:
            queryset: A filtered queryset based on the user's permissions.
        """
        qs = super().get_queryset(request)
        if request.user.is_superuser:
            return qs
        return qs.filter(conversation__user=request.user)  # Adjust based on your logic

    def save_model(self, request, obj, form, change):
        """
        Custom save method to set the 'sent_at' field when creating a new message.
        
        If the message is being created (not changed), set the 'sent_at' timestamp to the current time.
        Then call the parent save_model method to persist the object.

        Parameters:
            request (HttpRequest): The HTTP request object.
            obj (ChatMessage): The instance of the model being saved.
            form (ModelForm): The form instance with the model data.
            change (bool): Indicates if the model is being updated or created.
        """
        if not change:
            obj.sent_at = timezone.now()
        super().save_model(request, obj, form, change)


admin.site.register(ChatConversation, ChatConversationAdmin)
admin.site.register(ChatMessage, ChatMessageAdmin)
