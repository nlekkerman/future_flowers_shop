from django.contrib import admin
from .models import Human

@admin.register(Human)
class HumanAdmin(admin.ModelAdmin):
    list_display = ('first_name', 'last_name', 'age', 'email', 'last_modified', 'deleted')
    list_filter = ('deleted', 'last_modified')
    search_fields = ('first_name', 'last_name', 'email')
    readonly_fields = ('last_modified',)
    
    # Optional: Customize the ordering of records in the admin
    ordering = ('-last_modified',)  # Orders by last modified in descending order

    def delete_model(self, request, obj):
        # Override to perform a soft delete by setting the `deleted` flag to True
        obj.deleted = True
        obj.save()

    def get_queryset(self, request):
        # Override the default queryset to exclude soft-deleted records from the list view by default
        queryset = super().get_queryset(request)
        return queryset.filter(deleted=False)
