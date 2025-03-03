from django.urls import path
from . import views
app_name = 'seeds'

urlpatterns = [
    path('', views.seed_list, name='seed_list'),
    path('create-seed/', views.create_seed_view, name='create_seed'),
    path('edit/<int:id>/', views.edit_seed_view, name='edit_seed'),
    path('delete/<int:id>/', views.delete_seed_view, name='delete_seed'),
  
]