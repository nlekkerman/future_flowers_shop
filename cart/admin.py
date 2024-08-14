from django.contrib import admin
from .models import Cart, CartItem

class CartItemInline(admin.TabularInline):
    model = CartItem
    extra = 1  # How many blank forms to display initially

class CartAdmin(admin.ModelAdmin):
    list_display = ('user', 'created_at', 'updated_at')
    inlines = [CartItemInline]
    search_fields = ('user__username', 'user__email')
    list_filter = ('created_at', 'updated_at')

admin.site.register(Cart, CartAdmin)
admin.site.register(CartItem)
