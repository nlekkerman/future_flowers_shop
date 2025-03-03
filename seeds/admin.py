from django.contrib import admin
from .models import Seed

@admin.register(Seed)
class SeedAdmin(admin.ModelAdmin):
    """
    Admin interface for managing Seed objects in Django's admin panel.

    This class defines how the Seed model should be displayed and interacted with in the Django admin interface.
    It includes configuration for fields to display, search functionality, filters, and read-only fields for calculated values.

    Attributes:
        list_display (tuple): Specifies the fields to display in the list view of the admin interface.
        search_fields (tuple): Specifies which fields are searchable in the admin search bar.
        list_filter (tuple): Specifies filter options for narrowing down the list of seeds based on certain model fields.
        readonly_fields (tuple): Specifies fields that should be read-only in the admin form.

    Methods:
        calculate_discounted_price(obj): A method to calculate and display the discounted price of a seed 
                                         in the list view. The discounted price is calculated using the 
                                         model's `calculate_discounted_price` method.
        
    Example:
        # In the Django admin interface, you will see a list of seeds displayed with columns for:
        # Name, Scientific Name, Price, Discount, Stock Availability, and Discounted Price.
        # The Discounted Price will be calculated dynamically for each seed.
    """
    list_display = (
        'name', 
        'scientific_name', 
        'price', 
        'discount', 
        'is_in_stock', 
        'in_stock_number', 
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
