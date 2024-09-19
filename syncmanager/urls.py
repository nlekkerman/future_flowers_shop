# syncmanager/urls.py

from django.urls import path
from . import views
app_name = 'syncmanager'

urlpatterns = [
    path('api/get_seeds_to_localstorage/', views.get_seeds_to_localstorage, name='get_seeds_to_localstorage'),
    path('api/get_cart/', views.get_cart_data, name='get_cart_data'),
    
]