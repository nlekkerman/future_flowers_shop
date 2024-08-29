# /workspace/future_flowers_shop/asgi.py
import os
from django.core.asgi import get_asgi_application
from channels.routing import ProtocolTypeRouter, URLRouter
from channels.auth import AuthMiddlewareStack
from channels.security.websocket import AllowedHostsOriginValidator
from channels.layers import get_channel_layer
from communications import routing  # Import the routing file from the communications app

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'future_flowers_shop.settings')

application = ProtocolTypeRouter({
    "http": get_asgi_application(),
    "websocket": AllowedHostsOriginValidator(
        AuthMiddlewareStack(
            URLRouter(
                routing.websocket_urlpatterns  # Include WebSocket routing here
            )
        )
    ),
})

channel_layer = get_channel_layer()
o

