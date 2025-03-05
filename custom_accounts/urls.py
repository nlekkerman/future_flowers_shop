from django.urls import path
from .views import (
    register, send_newsletter, login, welcome_message, logout, profile, 
    admin_dashboard, approve_review, reject_review, delete_review, 
    edit_profile, approve_comment, reject_comment, delete_comment
)

"""
URL configurations for the custom_accounts app.

1. **register**: Handles user registration.
2. **login**: Handles user login.
3. **logout**: Logs out the currently authenticated user.
4. **edit_profile**: Allows users to edit their profile.
5. **profile**: Displays the user's profile page.
6. **admin_dashboard**: Provides an admin panel for managing users and content.
7. **approve_review**: Admin approves a user-submitted review (identified by `id`).
8. **reject_review**: Admin rejects a user-submitted review (identified by `id`).
9. **delete_review**: Admin deletes a user-submitted review (identified by `id`).
10. **approve_comment**: Admin approves a user-submitted comment (identified by `id`).
11. **reject_comment**: Admin rejects a user-submitted comment (identified by `id`).
12. **delete_comment**: Admin deletes a user-submitted comment (identified by `id`).
13. **send_newsletter**: Sends newsletters to users.
14. **welcome_message**: Displays a welcome message.

Each path is linked to its corresponding view function, which processes the request and returns the appropriate response.
"""

app_name = 'custom_accounts'

urlpatterns = [
    path('register/', register, name='account_signup'),
    path('login/', login, name='account_login'),
    path('logout/', logout, name='account_logout'),
    path('profile/edit/', edit_profile, name='edit_profile'),
    path('profile/', profile, name='profile'),
    path('admin/dashboard/', admin_dashboard, name='admin_dashboard'),

    # Review moderation by admin
    path('admin/review/<int:id>/approve/', approve_review, name='approve_review'),
    path('admin/review/<int:id>/reject/', reject_review, name='reject_review'),
    path('admin/review/<int:id>/delete/', delete_review, name='delete_review'),

    # Comment moderation by admin
    path('admin/comment/<int:id>/approve/', approve_comment, name='approve_comment'),
    path('admin/comment/<int:id>/reject/', reject_comment, name='reject_comment'),
    path('admin/comment/<int:id>/delete/', delete_comment, name='delete_comment'),

    path('send-newsletter/', send_newsletter, name='send_newsletter'),
    path('welcome_message/', welcome_message, name='welcome_message'),
]
