from django.urls import path
from . import views

urlpatterns = [
    path('', views.cart_detail, name='cart_detail'),
    path('add/<int:seed_id>/', views.add_to_cart, name='add_to_cart'),
    path('remove/<int:seed_id>/', views.remove_from_cart, name='remove_from_cart'),
    path('update/<int:seed_id>/', views.update_cart_item, name='update_cart_item'),
]