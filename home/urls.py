from django.urls import path
from . import views
app_name = 'home'
urlpatterns = [
    path('', views.home, name='home'),
    path('seed/<int:seed_id>/', views.seed_detail, name='seed_detail'),
   
]