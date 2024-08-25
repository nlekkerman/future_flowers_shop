from django.urls import path
from . import views

urlpatterns = [
    path('submit-review/', views.submit_review, name='submit_review'),
    path('submit-comment/', views.submit_comment, name='submit_comment'),
    path('edit-review/<int:review_id>/', views.edit_review, name='edit_review'),
    path('delete-review/<int:review_id>/', views.delete_review, name='delete_review'),
    path('edit-comment/<int:comment_id>/', views.edit_comment, name='edit_comment'),
    path('delete-comment/<int:comment_id>/', views.delete_comment, name='delete_comment'),
]
