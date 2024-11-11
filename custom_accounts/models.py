# custom_accounts/models.py

from django.db import models
from django.conf import settings
from django.contrib.auth.models import User
from cloudinary.models import CloudinaryField
from django.dispatch import receiver

class UserProfile(models.Model):
    """
    Model extending Django's User model to include additional user profile details.

    Fields:
        user (OneToOneField): A one-to-one relationship to Django's built-in User model.
        email (EmailField): Optional email field for the user, allowing a max of 254 characters.
        address (CharField): Optional field to store the user's address, up to 255 characters.
        phone_number (CharField): Optional phone number field with a max length of 20 characters.
        profile_image (CloudinaryField): Cloudinary-hosted field for storing the user's profile image.
        about_self (CharField): Optional short bio or description of the user, with a 255-character limit.
        receives_newsletter (BooleanField): Flag indicating if the user is subscribed to the newsletter (default is False).
    """
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='profile')
    email = models.EmailField(max_length=254, blank=True, null=True)
    address = models.CharField(max_length=255, blank=True, null=True)
    phone_number = models.CharField(max_length=20, blank=True, null=True)
    profile_image = CloudinaryField('image', blank=True, null=True)  
    about_self = models.CharField(max_length=255, blank=True, null=True)
    receives_newsletter = models.BooleanField(default=False)

    def __str__(self):
        """
        Returns a string representation of the UserProfile instance.

        Returns:
            str: The username of the associated User instance.
        """
        return self.user.username

    def get_profile_image_url(self):
        """
        Retrieves the URL of the user's profile image or returns a default image URL if none is provided.

        If the user has a profile image uploaded to Cloudinary, and it is not a placeholder, return its URL.
        Otherwise, return the URL to a default static image.

        Returns:
            str: URL of the profile image if available; otherwise, the URL of a default image.
        """
      
        if self.profile_image and hasattr(self.profile_image, 'url') and not 'placeholder_image' in self.profile_image.url:
            return self.profile_image.url
        return f'{settings.STATIC_URL}images/user-icon.png'

