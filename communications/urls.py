from django.urls import path
from . import views

app_name = 'communications'


urlpatterns = [
    path("conversations/", views.conversations, name="conversations"),
    path("chat/<int:user_id>/", views.chat_with_user, name="chat_with_user"),
    path("send_message_to_user/<int:conversation_id>/", views.send_message_to_user, name="send_message_to_user"),
   
    # Regular user chats with admin
    path("chat_with_admin/", views.chat_with_admin, name="chat_with_admin"),
    path("send_message_to_admin/<int:conversation_id>/", views.send_message_to_admin, name="send_message_to_admin"),
    path('contact/', views.contact_view, name='contact'),
    path('about/', views.about, name='about'),
    path('questions/', views.faq_view, name='questions'),
    path("search_users/", views.search_users, name="search_users"),

]
