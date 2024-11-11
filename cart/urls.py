from django.urls import path
from . import views

# Define the application namespace for URLs, allowing reverse URL resolution 
# to refer to URLs within this 'cart' application specifically.
app_name = 'cart' 

urlpatterns = [
    path('', views.cart_view, name='cart'), 
    path('api/add_to_cart/', views.add_to_cart, name='add_to_cart'),
    path('api/update_quantity/', views.update_quantity, name='update_quantity'),
    path('api/delete_item/', views.delete_item, name='delete_item'),
]