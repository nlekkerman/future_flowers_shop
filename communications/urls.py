from django.urls import path
from . import views

app_name = 'communications'

urlpatterns = [
    path('chats/', views.chat_list, name='chat_list'),
    path('chats/<int:pk>/', views.conversation_detail, name='conversation_detail'),
    path('user-chat-messages/', views.user_chat_messages, name='user_chat_messages'),
    path('admin/user-chat-messages/<int:conversation_id>/', views.admin_user_chat_messages, name='admin_user_chat_messages'),
    path('chat-bot/', views.chat_bot_view, name='chat_bot_view'),
    path('chat-bot/handle-choice/', views.chat_bot_handle_choice, name='chat_bot_handle_choice'),
    path('communications/mark_as_seen/', views.mark_as_seen, name='mark_as_seen'),
    
]
