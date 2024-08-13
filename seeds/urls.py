from django.urls import path
from . import views

urlpatterns = [
    path('', views.seed_list, name='seed_list'),  # Existing URL pattern for the seed list
    path('seeds/<int:id>/', views.seed_details, name='seed_details'),  # New URL pattern for seed details
]