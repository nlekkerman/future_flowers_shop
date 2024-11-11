from django.contrib import admin
from .models import UserProfile


class UserProfileAdmin(admin.ModelAdmin):
    """
    Custom admin interface for the UserProfile model.

    Attributes:
        list_display (tuple): Columns displayed in the UserProfile list view.
        search_fields (tuple): Fields that can be searched in the admin.
        list_filter (tuple): Fields that can be used to filter the list view.
    """
    list_display = ('get_username','email', 'address', 'phone_number', 'receives_newsletter') 
    search_fields = ('user__username','email','address', 'phone_number') 
    list_filter = ('receives_newsletter',)
    def get_username(self, obj):
        return obj.user.username 
    get_username.short_description = 'Username'

admin.site.register(UserProfile, UserProfileAdmin) 
