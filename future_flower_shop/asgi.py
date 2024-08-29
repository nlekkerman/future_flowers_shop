# /workspace/future_flower_shop/future_flower_shop/asgi.py

import os
from django.core.asgi import get_asgi_application
from channels.routing import ProtocolTypeRouter, URLRouter
from channels.auth import AuthMiddlewareStack
import communications.routing
import environ

# Initialize environment variables
env = environ.Env()
environ.Env.read_env()  # Reads .env file

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'future_flower_shop.settings')

application = ProtocolTypeRouter({
    "http": get_asgi_application(),
    # WebSocket chat handler
    "websocket": AuthMiddlewareStack(
        URLRouter(
            communications.routing.websocket_urlpatterns
        )
    ),
})
