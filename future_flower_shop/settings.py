"""
Django settings for future_flower_shop project.

Generated by 'django-admin startproject' using Django 5.1.

For more information on this file, see
https://docs.djangoproject.com/en/5.1/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/5.1/ref/settings/
"""

import os
import dj_database_url
from pathlib import Path
from django.contrib import messages
from decouple import config, Csv
import logging

logging.basicConfig(level=logging.DEBUG)

if os.path.exists('env.py'):
    import env

# Define environment variables using python-decouple
SECRET_KEY = config('SECRET_KEY')
DATABASES = {
    'default': dj_database_url.parse(config('DATABASE_URL')),
    'ATOMIC_REQUESTS': True,
}

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = os.getenv('SECRET_KEY')

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = [
    '8000-nlekkerman-futureflower-v9397r1bhgn.ws.codeinstitute-ide.net',
    '.herokuapp.com'
]

CSRF_TRUSTED_ORIGINS = [
    'https://*.gitpod.io',
    'https://*.herokuapp.com',
    'https://8000-nlekkerman-futureflower-v9397r1bhgn.ws.codeinstitute-ide.net'
]

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    
    # Third-party apps
    'django.contrib.sites',            # Required for allauth
    'allauth',                         # Django allauth for authentication
    'allauth.account',                 # Allauth for account management
    'allauth.socialaccount',           # Allauth for social account management
    'allauth.socialaccount.providers.google',  # Google provider for allauth
    'cloudinary',                      # Cloudinary for media management
    'cloudinary_storage', 
    'crispy_forms',
    'crispy_bootstrap4',
    # Custom apps
    'home',                            # Custom app for home page
    'seeds',                           # Custom app for seeds management
    'cart',                            # Custom app for cart management
    'custom_accounts',                 # Custom app for account management
    'checkout',
    'reviews',                       # custom app for checkout management
    'communications',
]


MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'whitenoise.middleware.WhiteNoiseMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'allauth.account.middleware.AccountMiddleware',  # Ensure allauth middleware is included
]


# Message tags
MESSAGE_TAGS = {
    messages.DEBUG: 'debug',
    messages.INFO: 'info',
    messages.SUCCESS: 'success',
    messages.WARNING: 'warning',
    messages.ERROR: 'error',
}

ROOT_URLCONF = 'future_flower_shop.urls'
CRISPY_TEMPLATE_PACK = 'bootstrap4'


TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [
            os.path.join(BASE_DIR, 'templates'),
            os.path.join(BASE_DIR, 'templates', 'allauth'),
        ],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
                'cart.context_processors.cart_context',
                'seeds.context_processors.seed_data',
                'communications.context_processors.chat_context',
                
            ],
            'builtins': [
                'crispy_forms.templatetags.crispy_forms_tags',
                'crispy_forms.templatetags.crispy_forms_field',
            ]
        },
    },
]

# Social Account Providers Configuration
SOCIALACCOUNT_PROVIDERS = {
    'google': {
        'SCOPE': [
            'profile',
            'email',
        ],
        'AUTH_PARAMS': {
            'access_type': 'online',
        },
        'OAUTH_PKCE_ENABLED': True,
        'APP': {
            'client_id': os.getenv('GOOGLE_CLIENT_ID'),
            'secret': os.getenv('GOOGLE_SECRET'),
            'key': ''
        }
    }
}
AUTHENTICATION_BACKENDS = (
    'django.contrib.auth.backends.ModelBackend',
    'allauth.account.auth_backends.AuthenticationBackend',
)
# settings.py
FREE_DELIVERY_THRESHOLD = 50
STANDARD_DELIVERY_PERCENTAGE = 10


SITE_ID = 1

WSGI_APPLICATION = 'future_flower_shop.wsgi.application'

# Database configuration
DATABASES = {
    'default': dj_database_url.parse(os.environ.get("DATABASE_URL"))
}

EMAIL_HOST_USER = os.environ.get('EMAIL_HOST_USER')
EMAIL_HOST_PASSWORD = os.environ.get('EMAIL_HOST_PASSWORD')

# Cloudinary configuration
CLOUDINARY_URL = os.getenv('CLOUDINARY_URL')
DEFAULT_FILE_STORAGE = 'cloudinary_storage.storage.MediaCloudinaryStorage'

# Password validation
AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]

# Internationalization
LANGUAGE_CODE = 'en-us'
TIME_ZONE = 'UTC'
USE_I18N = True
USE_TZ = True

# Media files (uploads)
MEDIA_URL = '/media/'
MEDIA_ROOT = BASE_DIR / 'media'

# Static files (CSS, JavaScript, Images)
STATICFILES_DIRS = [
    BASE_DIR / 'static',
]
STATIC_URL = '/static/'
STATIC_ROOT = BASE_DIR / 'staticfiles'

# Default primary key field type
DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'

# Allauth settings
ACCOUNT_AUTHENTICATION_METHOD = 'username'  # Options: 'username', 'email'
ACCOUNT_EMAIL_REQUIRED = True
ACCOUNT_EMAIL_VERIFICATION = 'mandatory'  # Options: 'optional', 'mandatory', 'none'
ACCOUNT_USERNAME_REQUIRED = True
LOGIN_REDIRECT_URL = '/'
LOGOUT_REDIRECT_URL = '/'

# Social Account Providers Configuration
SOCIALACCOUNT_PROVIDERS = {
    'google': {
        'SCOPE': [
            'profile',
            'email',
        ],
        'AUTH_PARAMS': {
            'access_type': 'online',
        },
        'OAUTH_PKCE_ENABLED': True,
        'APP': {
            'client_id': os.getenv('GOOGLE_CLIENT_ID'),
            'secret': os.getenv('GOOGLE_SECRET'),
            'key': ''
        }
    }
}
# Log the GOOGLE_CLIENT_ID and GOOGLE_SECRET values
logging.debug(f"GOOGLE_CLIENT_ID: {os.getenv('GOOGLE_CLIENT_ID')}")
logging.debug(f"GOOGLE_SECRET: {os.getenv('GOOGLE_SECRET')}")
