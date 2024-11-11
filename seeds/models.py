from django.db import models
from cloudinary.models import CloudinaryField
from django.utils import timezone
from decimal import Decimal


class Seed(models.Model):
    """
    A model representing a seed with attributes like name, scientific name, description, 
    planting and flowering months, category, height, sun preference, price, discount, 
    stock availability, and image.

    Attributes:
        name (CharField): The common name of the seed (e.g., 'Rose').
        scientific_name (CharField): The scientific name of the seed (e.g., 'Rosa spp.').
        description (TextField): A detailed description of the seed.
        planting_months_from (PositiveIntegerField): Month to start planting.
        planting_months_to (PositiveIntegerField): Month to end planting.
        flowering_months_from (PositiveIntegerField): Month to start flowering.
        flowering_months_to (PositiveIntegerField): Month to end flowering.
        category (CharField): The seed's category (e.g., 'rose', 'tree').
        height_from (DecimalField): Minimum plant height in meters.
        height_to (DecimalField): Maximum plant height in meters.
        sun_preference (CharField): Sun exposure required (e.g., 'full_sun').
        price (DecimalField): Price of the seed.
        discount (DecimalField): Discount percentage on the seed's price.
        is_in_stock (BooleanField): Indicates if the seed is in stock.
        created_at (DateTimeField): Timestamp when the seed was created.
        last_modified (DateTimeField): Timestamp when the seed was last modified.
        deleted (BooleanField): Indicates if the seed is marked as deleted.
        image (CloudinaryField): Image of the seed uploaded via Cloudinary.

    Methods:
        calculate_discounted_price(): Returns the price after applying the discount.
        has_discount(): Checks if the seed has a discount.
        __str__(): Returns the seed's name as a string representation.
    """
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