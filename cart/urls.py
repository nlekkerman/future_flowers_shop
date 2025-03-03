from django.urls import path
from . import views

# Define the application namespace for reverse URL resolution
app_name = 'cart'

urlpatterns = [
    path('', views.cart_view, name='cart'),  # Display the cart
    path('add/<int:seed_id>/', views.add_to_cart, name='add_to_cart'),  # Add item to cart
    path('remove/<int:item_id>/', views.remove_from_cart, name='remove_from_cart'),  # Remove item from cart
    path('update/<int:item_id>/', views.update_cart, name='update_cart'),  # Update item quantity
    path('clear/', views.clear_cart, name='clear_cart'),  # Clear the entire cart
]
