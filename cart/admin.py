from django.contrib import admin
from .models import Cart, CartItem

@admin.register(Cart)
class CartAdmin(admin.ModelAdmin):
    list_display = ('id', 'user', 'session_id', 'created_at', 'updated_at', 'last_modified', 'deleted')
    list_filter = ('deleted', 'created_at', 'updated_at')
    search_fields = ('user__username', 'session_id')

@admin.register(CartItem)
class CartItemAdmin(admin.ModelAdmin):
    list_display = ('cart', 'seed', 'quantity', 'last_modified', 'deleted')
    list_filter = ('deleted', 'last_modified')
    search_fields = ('cart__id', 'seed__name')
