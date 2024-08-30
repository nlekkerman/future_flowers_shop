# custom_accounts/urls.py
from django.urls import path
from .views import (register, login, logout, profile, debug_view,admin_dashboard, approve_review, reject_review, delete_review, approve_comment, reject_comment, delete_comment,conversation_detail_view )

urlpatterns = [
    path('register/', register, name='account_signup'),
    path('login/', login, name='account_login'),
    path('logout/', logout, name='account_logout'),
    path('profile/', profile, name='profile'),
    path('custom_accounts/debug/', debug_view, name='debug'),
    path('admin/dashboard/', admin_dashboard, name='admin_dashboard'),
    path('admin/review/<int:id>/approve/', approve_review, name='approve_review'),
    path('admin/review/<int:id>/reject/', reject_review, name='reject_review'),
    path('admin/review/<int:id>/delete/', delete_review, name='delete_review'),
    path('admin/comment/<int:id>/approve/', approve_comment, name='approve_comment'),
    path('admin/comment/<int:id>/reject/', reject_comment, name='reject_comment'),
    path('admin/conversations/<int:conversation_id>/', conversation_detail_view, name='view_conversation'),
    path('admin/comment/<int:id>/delete/', delete_comment, name='delete_comment'),


]
