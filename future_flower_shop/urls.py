# urls.py

from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import path, include
from custom_accounts.views import welcome_message

urlpatterns = [
    path('admin/', admin.site.urls),
    
    # Allauth URLs for authentication (including social login)
    path('accounts/', include('allauth.urls')),
    
    # Custom accounts URLs (if you have any specific routes for custom account handling)
    path('custom_accounts/', include('custom_accounts.urls')),
    
    # Custom view for welcome message
    path('welcome/', welcome_message, name='welcome_message'),
    
    # Seeds application URLs
    path('seeds/', include('seeds.urls')),
    
    # Cart application URLs
    path('cart/', include('cart.urls')),
    
    # Home application URLs
    path('', include('home.urls')),
]

# Serve media files during development
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
