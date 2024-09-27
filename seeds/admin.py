from django.contrib import admin
from .models import Seed

@admin.register(Seed)
class SeedAdmin(admin.ModelAdmin):
    # Display the fields in the list view
    list_display = (
        'name', 
        'scientific_name', 
        'price', 
        'discount', 
        'is_in_stock', 
        'calculate_discounted_price'
    )

    # Fields to search by
    search_fields = ('name', 'scientific_name', 'category')

    # Filter options in the list view
    list_filter = ('category', 'sun_preference', 'is_in_stock')

    # Read-only fields for calculated price
    readonly_fields = ('calculate_discounted_price',)

    def calculate_discounted_price(self, obj):
        """Display the calculated discounted price in the list view."""
        return obj.calculate_discounted_price()
    calculate_discounted_price.short_description = 'Discounted Price'
