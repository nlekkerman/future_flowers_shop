from django.urls import path
from . import views

app_name = 'reviews'

urlpatterns = [
   path('api/reviews/', views.fetch_reviews, name='fetch_reviews'),
   path('api/write/', views.write_review, name='write_review'),
   path('api/update_review/', views.update_review, name='update_review'),  
   path('api/delete_review/<int:review_id>/', views.delete_review, name='delete_review'),
   path('api/comment/leave/<int:review_id>/', views.leave_comment, name='leave_comment'),
   path('api/edit_comment/update/<int:review_id>/<int:comment_id>/', views.update_comment, name='update_comment'),
   path('api/comment/delete/<int:review_id>/<int:comment_id>/', views.delete_comment, name='delete_comment'),

]
