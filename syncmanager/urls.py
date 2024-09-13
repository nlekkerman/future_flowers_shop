# syncmanager/urls.py

from django.urls import path
from . import views
app_name = 'syncmanager'

urlpatterns = [
    path('api/get_seeds_to_localstorage/', views.get_seeds_to_localstorage, name='get_seeds_to_localstorage'),
    path('api/cart/', views.get_cart, name='get_cart'),
    path('api/update-cart/', views.update_cart, name='update_cart'),
    path('api/seeds-with-last-sync/', views.get_seeds_with_last_sync, name='get_seeds_with_last_sync'),


]