from django.contrib import admin
from .models import Review, Comment

@admin.register(Review)
class ReviewAdmin(admin.ModelAdmin):
    """
    Admin configuration for managing the Review model in the Django admin panel.

    Attributes:
        list_display (tuple): Specifies the fields to display in the review list view.
        list_filter (tuple): Defines the fields by which the reviews can be filtered.
        search_fields (tuple): Specifies the fields to be searched in the admin panel.
        actions (list): A list of custom admin actions for handling reviews.

    Methods:
        approve_reviews(request, queryset): Approves the selected reviews by updating their status to 'approved'.
        reject_reviews(request, queryset): Rejects the selected reviews by updating their status to 'rejected'.
        delete_reviews(request, queryset): Deletes the selected reviews from the database.

    """
 
    list_display = ('user', 'rating', 'status', 'created_at', 'updated_at')
    list_filter = ('status', 'created_at', 'rating')
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
    """
    Admin configuration for managing the Comment model in the Django admin panel.

    Attributes:
        list_display (tuple): Specifies the fields to display in the comment list view.
        list_filter (tuple): Defines the fields by which the comments can be filtered.
        search_fields (tuple): Specifies the fields to be searched in the admin panel.
        actions (list): A list of custom admin actions for handling comments.

    Methods:
        approve_comments(request, queryset): Approves the selected comments by updating their status to 'approved'.
        reject_comments(request, queryset): Rejects the selected comments by updating their status to 'rejected'.
        delete_comments(request, queryset): Deletes the selected comments from the database.

    """
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
