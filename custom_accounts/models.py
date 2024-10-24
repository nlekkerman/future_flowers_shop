# custom_accounts/models.py

from django.db import models
from django.contrib.auth.models import User
from cloudinary.models import CloudinaryField  # Import CloudinaryField for image upload

class UserProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='profile')
    address = models.CharField(max_length=255, blank=True, null=True)
    phone_number = models.CharField(max_length=20, blank=True, null=True)
    profile_image = CloudinaryField('image', default='placeholder_image')  # Set default image
    about_self = models.CharField(max_length=255, blank=True, null=True)

    def __str__(self):
        return self.user.username

    # Return the profile image or a default one if not set
    def get_profile_image(self):
        # Return HTTPS URL
        return self.profile_image.url if self.profile_image else '/static/media/images/user-icon.png'
