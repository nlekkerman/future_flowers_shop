from django.db.models.signals import post_save
from django.dispatch import receiver
from django.contrib.auth.models import User
from custom_accounts.models import UserProfile

@receiver(post_save, sender=User)
def manage_user_profile(sender, instance, created, **kwargs):
    if created:
        # Create a UserProfile when a new User is created
        UserProfile.objects.create(user=instance)
    else:
        # Update the existing UserProfile if it exists
        try:
            profile = instance.profile
            profile.save()
        except UserProfile.DoesNotExist:
            # Create the UserProfile if it doesn't exist
            UserProfile.objects.create(user=instance)
