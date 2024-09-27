from django.urls import path
from . import views
app_name = 'seeds'
urlpatterns = [
    path('', views.seed_list, name='seed_list'),  # Existing URL pattern for the seed list
    path('seeds/<int:id>/', views.seed_details, name='seed_details'),  # New URL pattern for seed details
    path('search/', views.search_results, name='search_results'),  # URL pattern for search results
    path('seeds/', views.seeds_view, name='seeds'),
    path('create-seed/', views.create_seed_view, name='create_seed'),
    path('api/seeds/', views.seed_list_api, name='seed_list_api'),
    path('seeds/<int:id>/edit/', views.edit_seed_view, name='edit_seed'),  # Edit seed
    path('seeds/<int:id>/delete/', views.delete_seed_view, name='delete_seed'),  # Delete seed
]