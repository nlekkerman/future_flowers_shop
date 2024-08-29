from django.urls import path
from . import views

app_name = 'communications'
urlpatterns = [
   path('chat/', views.chat_view, name='chat_view'),
  
    ]
