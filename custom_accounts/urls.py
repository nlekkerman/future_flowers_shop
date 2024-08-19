# custom_accounts/urls.py
from django.urls import path
from .views import register, login, logout, profile

urlpatterns = [
    path('register/', register, name='account_signup'),
    path('login/', login, name='account_login'),
    path('logout/', logout, name='account_logout'),
    path('profile/', profile, name='profile'),
]
