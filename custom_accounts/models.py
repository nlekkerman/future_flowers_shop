# custom_accounts/models.py

from django.db import models
from django.conf import settings
from django.contrib.auth.models import User
from cloudinary.models import CloudinaryField
from django.dispatch import receiver

class UserProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='profile')
    email = models.EmailField(max_length=254, blank=True, null=True)
    address = models.CharField(max_length=255, blank=True, null=True)
    phone_number = models.CharField(max_length=20, blank=True, null=True)
    profile_image = CloudinaryField('image', blank=True, null=True)  
    about_self = models.CharField(max_length=255, blank=True, null=True)
    receives_newsletter = models.BooleanField(default=False)

    def __str__(self):
        return self.user.username

    def get_profile_image_url(self):
        # Check if the user has an uploaded profile image
        if self.profile_image and hasattr(self.profile_image, 'url') and not 'placeholder_image' in self.profile_image.url:
            return self.profile_image.url
        # Return static default image if no profile image is available
        return f'{settings.STATIC_URL}images/user-icon.png'

