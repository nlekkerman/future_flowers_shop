# syncmanager/urls.py

from django.urls import path
from . import views
app_name = 'syncmanager'

urlpatterns = [
    path('api/get_seeds_to_localstorage/', views.get_seeds_to_localstorage, name='get_seeds_to_localstorage'),
    path('api/get_cart/', views.get_cart_data, name='get_cart_data'),
    path('api/get_user_messages/', views.get_user_messages, name='get_user_messages'),
    path('api/get_user_conversations/<int:user_id>/', views.get_user_conversations, name='get_user_conversations'),
    path('api/get_user_id/', views.get_user_id, name='get_user_id'),
    path('api/get_conversation_messages/<int:conversation_id>/', views.get_conversation_messages, name='get_conversation_messages'),
    path('api/send_message/<int:conversation_id>/', views.send_message, name='send_message'),
    path('api/get_username/', views.get_username, name='get_username'),
    path('api/fetch_messages/<int:conversation_id>/', views.fetch_messages, name='fetch_messages'),
    path('api/check_superuser/', views.check_superuser_status, name='check_superuser_status'),
    path('api/message_counts/', views.get_message_counts, name='get_message_counts'),
    path('api/update-message-status/', views.update_message_status, name='update-message-status'),
]
