from django.urls import path
from . import views
from .webhooks import webhook

"""
    URL patterns for the checkout app:
    1. Checkout page - 'checkout': Initiates the checkout process.
    2. Success page - 'checkout_success': Displays order success details using order number.
    3. Cache checkout data - 'cache_checkout_data': Caches temporary checkout data.
    4. Order details - 'order_detail': Displays order details using order number.
    5. Webhook - 'webhook': Handles payment processing events like Stripe webhooks.
    """

urlpatterns = [
    path('', views.checkout, name='checkout'),
    path('success/<order_number>/', views.checkout_success, name='checkout_success'),
    path('cache_checkout_data/', views.cache_checkout_data, name='cache_checkout_data'),
    path('order/<str:order_number>/', views.order_detail, name='order_detail'),
    path('wh/', webhook, name='webhook'),

]
