from django.http import JsonResponse, HttpResponseForbidden
from django.shortcuts import get_object_or_404, redirect, render
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.views.decorators.csrf import csrf_exempt
from .models import Review, Comment
from .forms import ReviewForm, CommentForm, EditReviewForm
from seeds.models import Seed
import logging

# Configure logging
logger = logging.getLogger(__name__)
@csrf_exempt
@login_required
def submit_review(request):
    if request.method == 'POST':
        form = ReviewForm(request.POST)
        seed_id = request.POST.get('seed_id')
        seed = get_object_or_404(Seed, id=seed_id)
        review = form.save(commit=False)
        review.seed = seed

        if form.is_valid():
            try:
                review.status = 'pending'
                review.user = request.user
                review.save()
                return JsonResponse({'success': True, 'message': "Review submitted and is awaiting approval."})
            except Exception as e:
                logger.error(f"Error submitting review for seed {seed_id}: {e}")
                return JsonResponse({'success': False, 'message': "An error occurred."})
        else:
            return JsonResponse({'success': False, 'message': "There was an error with your submission."})

    return JsonResponse({'success': False, 'message': "Invalid request method."})

@csrf_exempt
@login_required
def submit_comment(request):
    if request.method == 'POST':
        form = CommentForm(request.POST)
        review_id = request.POST.get('review_id')
        review = get_object_or_404(Review, id=review_id)
        comment = form.save(commit=False)
        comment.review = review
        comment.status = 'pending'
        comment.user = request.user

        if form.is_valid():
            try:
                comment.save()
                return JsonResponse({'success': True, 'message': "Comment added successfully and is pending approval."})
            except Exception as e:
                logger.error(f"Error submitting comment for review {review_id}: {e}")
                return JsonResponse({'success': False, 'message': "An error occurred while submitting your comment."})
        else:
            return JsonResponse({'success': False, 'message': "There was an error with your submission."})

    return JsonResponse({'success': False, 'message': "Invalid request method."})

@csrf_exempt
@login_required
def edit_review(request, review_id):
    review = get_object_or_404(Review, id=review_id)
    if request.user != review.user:
        raise PermissionDenied()

    if request.method == 'POST':
        form = EditReviewForm(request.POST, instance=review)
        if form.is_valid():
            try:
                review.status = 'pending'
                form.save()
                return JsonResponse({'success': True, 'message': "Your review has been updated and is pending approval."})
            except Exception as e:
                logger.error(f"Error updating review {review_id}: {e}")
                return JsonResponse({'success': False, 'message': "An error occurred while updating your review."})
        else:
            return JsonResponse({'success': False, 'message': "There was an error with your submission."})

    return JsonResponse({'success': False, 'message': "Invalid request method."})

@csrf_exempt
@login_required
def delete_review(request, review_id):
    review = get_object_or_404(Review, id=review_id, user=request.user)
    if request.method == 'POST':
        try:
            review.delete()
            return JsonResponse({'success': True, 'message': "Review deleted successfully."})
        except Exception as e:
            logger.error(f"Error deleting review: {e}")
            return JsonResponse({'success': False, 'message': "An error occurred while deleting your review."})

    return JsonResponse({'success': False, 'message': "Invalid request method."})

@csrf_exempt
@login_required
def edit_comment(request, comment_id):
    comment = get_object_or_404(Comment, id=comment_id, user=request.user)
    form = CommentForm(request.POST or None, instance=comment)

    if request.method == 'POST':
        if form.is_valid():
            try:
                form.save()
                return JsonResponse({'success': True, 'message': "Comment updated successfully."})
            except Exception as e:
                logger.error(f"Error updating comment {comment_id}: {e}")
                return JsonResponse({'success': False, 'message': "An error occurred while updating your comment."})
        else:
            return JsonResponse({'success': False, 'message': "There was an error with your submission."})

    return JsonResponse({'success': False, 'message': "Invalid request method."})

@csrf_exempt
@login_required
def delete_comment(request, comment_id):
    comment = get_object_or_404(Comment, id=comment_id, user=request.user)
    if request.method == 'POST':
        try:
            comment.delete()
            return JsonResponse({'success': True, 'message': "Comment deleted successfully."})
        except Exception as e:
            logger.error(f"Error deleting comment: {e}")
            return JsonResponse({'success': False, 'message': "An error occurred while deleting your comment."})

    return JsonResponse({'success': False, 'message': "Invalid request method."})