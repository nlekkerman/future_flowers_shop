from django.urls import path
from . import views

app_name = 'cart'  # This defines the namespace for this app

urlpatterns = [
    path('', views.cart_view, name='cart'),  # This is the view for the cart page
    path('api/add_to_cart/', views.add_to_cart, name='add_to_cart'),
    path('api/update_quantity/', views.update_quantity, name='update_quantity'),
    path('api/delete_item/', views.delete_item, name='delete_item'),
]