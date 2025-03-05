from django.urls import path
from . import views

"""
URL configurations for the communications app.

1. **conversations**: Displays all conversations of the logged-in user or superuser.
2. **chat_with_user**: Initiates a chat between the logged-in user and another user (identified by `user_id`).
3. **send_message_to_user**: Sends a message to a specific user within a conversation (identified by `conversation_id`).
4. **chat_with_admin**: Starts a chat between a non-admin user and an admin.
5. **send_message_to_admin**: Sends a message from a user to an admin in a conversation (identified by `conversation_id`).
6. **contact**: Displays the contact information page.
7. **about**: Displays the about us page.
8. **faq**: Displays the frequently asked questions page.
9. **search_users**: Provides a search functionality for finding users by query.

Each path is linked to its corresponding view function to handle the request and response.
"""


app_name = 'communications'


urlpatterns = [
    path("conversations/", views.conversations, name="conversations"),
    path("chat/<int:user_id>/", views.chat_with_user, name="chat_with_user"),
    path("send_message_to_user/<int:conversation_id>/", views.send_message_to_user, name="send_message_to_user"),
    path("chat_with_admin/", views.chat_with_admin, name="chat_with_admin"),
    path("send_message_to_admin/<int:conversation_id>/", views.send_message_to_admin, name="send_message_to_admin"),
    path('contact/', views.contact_view, name='contact'),
    path('about/', views.about, name='about'),
    path('faq/', views.faq_view, name='faq'),
    path("search_users/", views.search_users, name="search_users"),

]
