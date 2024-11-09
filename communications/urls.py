from django.urls import path
from . import views

app_name = 'communications'

urlpatterns = [
    path('user-chat-messages/', views.user_chat_messages, name='user_chat_messages'),
    path('admin/user-chat-messages/<int:conversation_id>/', views.admin_user_chat_messages, name='admin_user_chat_messages'),
    path('mark-as-seen/', views.mark_as_seen, name='mark_as_seen'),
    path('api/new-messages-count/', views.NewMessagesCountAPIView.as_view(), name='new-messages-count'),
    path('contact/', views.contact_view, name='contact'),
    path('about/', views.about, name='about'),
    path('questions/', views.faq_view, name='questions'),

]
