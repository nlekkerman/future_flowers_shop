from django.urls import path
from . import views

"""
URL patterns for the shopping cart:
- '' (cart): Displays the user's cart.
- 'add/<int:seed_id>/': Adds a seed to the cart.
- 'remove/<int:item_id>/': Removes an item from the cart.
- 'update/<int:item_id>/': Updates the quantity of an item in the cart.
- 'clear/': Clears all items from the cart.
"""

app_name = 'cart'

urlpatterns = [
    path('', views.cart_view, name='cart'),
    path('add/<int:seed_id>/', views.add_to_cart, name='add_to_cart'),
    path('remove/<int:item_id>/', views.remove_from_cart, name='remove_from_cart'),
    path('update/<int:item_id>/', views.update_cart, name='update_cart'),
    path('clear/', views.clear_cart, name='clear_cart'),
]


