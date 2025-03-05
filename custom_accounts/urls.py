# custom_accounts/urls.py
from django.urls import path

from .views import (register,send_newsletter, login,welcome_message, logout, profile, admin_dashboard, approve_review, reject_review, delete_review,edit_profile, approve_comment, reject_comment, delete_comment )
app_name = 'custom_accounts'
urlpatterns = [
    path('register/', register, name='account_signup'),
    path('login/', login, name='account_login'),
    path('logout/', logout, name='account_logout'),
    path('profile/edit/', edit_profile, name='edit_profile'),
    path('profile/', profile, name='profile'),
    path('admin/dashboard/', admin_dashboard, name='admin_dashboard'),
    path('admin/review/<int:id>/approve/', approve_review, name='approve_review'),
    path('admin/review/<int:id>/reject/', reject_review, name='reject_review'),
    path('admin/review/<int:id>/delete/', delete_review, name='delete_review'),
    path('admin/comment/<int:id>/approve/', approve_comment, name='approve_comment'),
    path('admin/comment/<int:id>/reject/', reject_comment, name='reject_comment'),
    path('admin/comment/<int:id>/delete/', delete_comment, name='delete_comment'),
    path('send-newsletter/', send_newsletter, name='send_newsletter'),
    path('welcome_message/',welcome_message, name='welcome_message'),
]

