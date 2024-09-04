from django.urls import path
from . import views
app_name = 'human'
urlpatterns = [
    path('list/', views.human_list, name='human_list'),
    path('human/<int:pk>/', views.human_detail, name='human_detail'),
    path('human/new/', views.human_create, name='human_create'),
    path('human/<int:pk>/edit/', views.human_update, name='human_update'),
    path('human/<int:pk>/delete/', views.human_delete, name='human_delete'),
     path('api/humans/', views.fetch_all_humans, name='fetch_all_humans'),
     path('api/humans/', views.api_humans, name='api_humans'),

]
