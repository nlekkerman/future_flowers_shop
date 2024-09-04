from django.urls import path
from . import views

app_name = 'cart'  # This defines the namespace for this app

urlpatterns = [
    path('', views.cart_view, name='cart'),  # This is the view for the cart page
    path('add/<int:seed_id>/', views.add_to_cart, name='add_to_cart'),
    path('remove/<int:seed_id>/', views.remove_from_cart, name='remove_from_cart'),
    path('update/<int:seed_id>/', views.update_cart_item, name='update_cart_item'),
    path('update-checkout/<int:seed_id>/', views.update_checkout_cart_item, name='update_checkout_cart_item'),
    path('max_quantity/<int:seed_id>/', views.get_max_possible_quantity, name='max_quantity'),
    path('clear-cart-item/', views.clear_cart_item, name='clear_cart_item'),
]