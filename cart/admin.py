from django.contrib import admin
from .models import Cart, CartItem
"""
This file customizes the Django admin interface for managing Cart and CartItem models,
allowing for efficient administration of carts and their contents.

The @admin.register decorator is used to register the models with the Django admin 
and apply the specified customizations, such as list display fields, filters, and search options.
"""

@admin.register(Cart)
class CartAdmin(admin.ModelAdmin):
    """
    Customizes the Cart model's display in the Django admin interface.
    
    Attributes:
        list_display (tuple): Specifies fields to be displayed in the list view for each Cart entry.
        list_filter (tuple): Adds filter options in the admin sidebar for easy access to deleted and time-related carts.
        search_fields (tuple): Allows for search functionality in the admin interface by user username or session ID.
    """
    
    list_display = ('id', 'user', 'session_id', 'created_at', 'updated_at', 'last_modified', 'deleted')
    list_filter = ('deleted', 'created_at', 'updated_at')
    search_fields = ('user__username', 'session_id')

@admin.register(CartItem)
class CartItemAdmin(admin.ModelAdmin):
    """
    Customizes the CartItem model's display in the Django admin interface.
    
    Attributes:
        list_display (tuple): Specifies fields to display for each CartItem entry, providing a quick view of cart details.
        list_filter (tuple): Adds a filter for deleted status and last modification date, helping to quickly locate items.
        search_fields (tuple): Enables search within CartItem entries by cart ID or seed name for faster access.
    """

    list_display = ('cart', 'seed', 'quantity', 'last_modified', 'deleted')
    list_filter = ('deleted', 'last_modified')
    search_fields = ('cart__id', 'seed__name')
