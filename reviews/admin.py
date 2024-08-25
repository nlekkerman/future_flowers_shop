from django.contrib import admin
from .models import Review, Comment

@admin.register(Review)
class ReviewAdmin(admin.ModelAdmin):
    list_display = ('seed', 'user', 'rating', 'is_approved', 'created_at')
    list_filter = ('is_approved', 'created_at', 'rating')
    search_fields = ('user__username', 'seed__name', 'comment')
    actions = ['approve_reviews']

    def approve_reviews(self, request, queryset):
        queryset.update(is_approved=True)
    approve_reviews.short_description = "Approve selected reviews"

@admin.register(Comment)
class CommentAdmin(admin.ModelAdmin):
    list_display = ('review', 'user', 'text', 'created_at')
    list_filter = ('created_at',)
    search_fields = ('user__username', 'text')
