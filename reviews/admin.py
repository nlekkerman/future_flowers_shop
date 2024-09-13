from django.contrib import admin
from .models import Review, Comment

@admin.register(Review)
class ReviewAdmin(admin.ModelAdmin):
    # Removed 'seed' from list_display
    list_display = ('user', 'rating', 'status', 'created_at', 'updated_at')
    list_filter = ('status', 'created_at', 'rating')
    # Removed 'seed__name' from search_fields
    search_fields = ('user__username', 'comment')
    actions = ['approve_reviews', 'reject_reviews', 'delete_reviews']

    def approve_reviews(self, request, queryset):
        updated_count = queryset.update(status='approved')
        self.message_user(request, f"{updated_count} reviews have been approved.")

    def reject_reviews(self, request, queryset):
        updated_count = queryset.update(status='rejected')
        self.message_user(request, f"{updated_count} reviews have been rejected.")

    def delete_reviews(self, request, queryset):
        deleted_count, _ = queryset.delete()
        self.message_user(request, f"{deleted_count} reviews have been deleted.")

    approve_reviews.short_description = "Approve selected reviews"
    reject_reviews.short_description = "Reject selected reviews"
    delete_reviews.short_description = "Delete selected reviews"

@admin.register(Comment)
class CommentAdmin(admin.ModelAdmin):
    list_display = ('review', 'user', 'text', 'status', 'created_at', 'updated_at')
    list_filter = ('status', 'created_at')
    search_fields = ('user__username', 'text')
    actions = ['approve_comments', 'reject_comments', 'delete_comments']

    def approve_comments(self, request, queryset):
        updated_count = queryset.update(status='approved')
        self.message_user(request, f"{updated_count} comments have been approved.")
    
    def reject_comments(self, request, queryset):
        updated_count = queryset.update(status='rejected')
        self.message_user(request, f"{updated_count} comments have been rejected.")
    
    def delete_comments(self, request, queryset):
        deleted_count, _ = queryset.delete()
        self.message_user(request, f"{deleted_count} comments have been deleted.")

    approve_comments.short_description = "Approve selected comments"
    reject_comments.short_description = "Reject selected comments"
    delete_comments.short_description = "Delete selected comments"
