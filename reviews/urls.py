from django.urls import path
from . import views

app_name = 'reviews'

urlpatterns = [
   path('', views.reviews, name='reviews'),
   path('review/edit/<int:review_id>/', views.edit_review, name='edit_review'),
   path('review/delete/<int:review_id>/', views.delete_review, name='delete_review'),
   path('comment/edit/<int:comment_id>/', views.edit_comment, name='edit_comment'),
   path('comment/delete/<int:comment_id>/', views.delete_comment, name='delete_comment'),

]
