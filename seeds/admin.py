from django.contrib import admin
from .models import Seed

@admin.register(Seed)
class SeedAdmin(admin.ModelAdmin):
    # Display the fields in the list view
    list_display = ('name', 'scientific_name', 'price', 'discount', 'is_in_stock', 'calculate_discounted_price')

    # Fields to search by
    search_fields = ('name', 'scientific_name', 'category')

    # Filter options in the list view (use the field `is_in_stock`)
    list_filter = ('category', 'sun_preference', 'is_in_stock')  # Correctly use the boolean field here
