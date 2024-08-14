from django.contrib import admin
from .models import Seed

@admin.register(Seed)
class SeedAdmin(admin.ModelAdmin):
    list_display = ('name', 'scientific_name', 'price', 'discount', 'in_stock', 'calculate_discounted_price', 'is_in_stock')
    search_fields = ('name', 'scientific_name', 'category')
    list_filter = ('category', 'sun_preference')
