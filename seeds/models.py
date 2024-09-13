from django.db import models
from cloudinary.models import CloudinaryField
from django.utils import timezone
from decimal import Decimal


class Seed(models.Model):
    CATEGORY_CHOICES = [
        ('rose', 'Rose'),
        ('flower', 'Flower'),
        ('tree', 'Tree'),
        ('bush', 'Bush'),
    ]

    # Seed attributes
    name = models.CharField(max_length=200)
    scientific_name = models.CharField(max_length=200)
    description = models.TextField()
    planting_months_from = models.PositiveIntegerField()
    planting_months_to = models.PositiveIntegerField()
    flowering_months_from = models.PositiveIntegerField()
    flowering_months_to = models.PositiveIntegerField()
    category = models.CharField(max_length=100, choices=CATEGORY_CHOICES, default='unknown')
    height_from = models.DecimalField(max_digits=5, decimal_places=2, default=0.00, help_text="Minimum height in meters")
    height_to = models.DecimalField(max_digits=5, decimal_places=2, default=0.00, help_text="Maximum height in meters")
    sun_preference = models.CharField(
        max_length=20,
        choices=[('full_sun', 'Full Sun'), ('partly', 'Partly'), ('full_shade', 'Full Shade')]
    )
    price = models.DecimalField(max_digits=10, decimal_places=2)
    discount = models.DecimalField(max_digits=5, decimal_places=2, default=0.00)
    is_in_stock = models.BooleanField(default=True)
    created_at = models.DateTimeField(default=timezone.now)
    last_modified = models.DateTimeField(auto_now=True)
    deleted = models.BooleanField(default=False)

    # Cloudinary image field
    image = CloudinaryField('image', blank=True, null=True, help_text="Upload an image of the seed")

    def calculate_discounted_price(self):
        """Calculate the price after discount."""
        if self.discount > 0:
            discounted_price = self.price - (self.price * (self.discount / 100))
            return Decimal(discounted_price).quantize(Decimal('0.01'))
        return self.price


    def has_discount(self):
        """Check if the seed has a discount."""
        return self.discount > 0

    def __str__(self):
        return self.name