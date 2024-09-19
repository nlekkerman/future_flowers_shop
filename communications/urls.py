from django.urls import path
from . import views

app_name = 'communications'

urlpatterns = [
    path('user-chat-messages/', views.user_chat_messages, name='user_chat_messages'),
    path('admin/user-chat-messages/<int:conversation_id>/', views.admin_user_chat_messages, name='admin_user_chat_messages'),
    path('chat-bot/', views.chat_bot_view, name='chat_bot_view'),
    path('chat-bot/handle-choice/', views.chat_bot_handle_choice, name='chat_bot_handle_choice'),
    path('mark-as-seen/', views.mark_as_seen, name='mark_as_seen'),
]
