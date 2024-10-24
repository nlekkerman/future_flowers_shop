from django.contrib import admin
from .models import UserProfile

# Custom admin for UserProfile
class UserProfileAdmin(admin.ModelAdmin):
    list_display = ('get_username', 'address', 'phone_number')  # Display username, address, and phone number
    search_fields = ('user__username', 'address', 'phone_number')  # Search by username, address, or phone number

    def get_username(self, obj):
        return obj.user.username  # Return the username from the related User model
    get_username.short_description = 'Username'  # Set a short description for the column in the admin

admin.site.register(UserProfile, UserProfileAdmin)  # Register the UserProfile model
