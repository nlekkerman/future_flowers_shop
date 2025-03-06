from django.urls import path
from . import views


app_name = 'home'


""" URL configurations for the 'home' app, mapping URLs to views for the home page 
and individual seed details, enabling navigation throughout the seed catalog.
"""
urlpatterns = [
    path('', views.home, name='home'),
    path('seed/<int:seed_id>/', views.seed_detail, name='seed_detail'),
   
]