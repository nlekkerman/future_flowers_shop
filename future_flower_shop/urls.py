# urls.py

from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import path, include
from django.conf.urls import handler404
from custom_accounts.views import custom_404



urlpatterns = [
    path('admin/', admin.site.urls),
    
    # Allauth URLs for authentication (including social login)
    path('accounts/', include('allauth.urls')),
    
    # Custom accounts URLs (if you have any specific routes for custom account handling)
    path('custom_accounts/', include('custom_accounts.urls')),

    # Seeds application URLs
    path('seeds/', include('seeds.urls')),

    # Checkout application URLs
    path('checkout/', include('checkout.urls')), 
    
    # Cart application URLs
    path('cart/', include('cart.urls')),
    
    # Home application URLs
    path('', include('home.urls')),

    # Include reviews app URLs
    path('reviews/', include('reviews.urls')),  

    path('communications/', include('communications.urls')),


]

handler404 = 'custom_accounts.views.custom_404'   

# Serve media files during development
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
