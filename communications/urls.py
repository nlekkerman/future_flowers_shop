from django.urls import path
from . import views

app_name = 'communications'
urlpatterns = [
   path('chats/', views.chat_list, name='chat_list'),
   path('chats/<int:pk>/', views.conversation_detail, name='conversation_detail'),
   path('user-chat-messages/', views.user_chat_messages, name='user_chat_messages'),

  
   ]
