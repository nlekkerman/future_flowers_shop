from django.urls import path
from . import views

app_name = 'reviews'

urlpatterns = [
   path('api/reviews/', views.fetch_reviews, name='fetch_reviews'),
   path('api/write/', views.write_review, name='write_review'),
   path('api/update_review/', views.update_review, name='update_review'),  # URL for updating reviews
   path('api/delete_review/<int:review_id>/', views.delete_review, name='delete_review'),  # URL for deleting reviews
]
