from django.urls import path
from . import views

urlpatterns = [
    path('', views.checkout, name='checkout'),
    path('success/<order_number>/', views.order_success, name='order_success'),
]
