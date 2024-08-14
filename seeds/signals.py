from django.db.models.signals import post_save
from django.dispatch import receiver
from .models import Seed

@receiver(post_save, sender=Seed)
def seed_post_save(sender, instance, **kwargs):
    """Perform actions after a Seed instance is saved."""
    # Example: Print a message or perform any other action
    print(f'Seed {instance.name} has been saved.')
