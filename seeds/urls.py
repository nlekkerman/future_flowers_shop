from django.urls import path
from . import views

urlpatterns = [
    path('', views.seed_list, name='seed_list'),  # Existing URL pattern for the seed list
    path('seeds/<int:id>/', views.seed_details, name='seed_details'),  # New URL pattern for seed details
    path('search/', views.search_results, name='search_results'),  # URL pattern for search results
    path('seeds/', views.seeds_view, name='seeds'),

]