from django.http import JsonResponse
from django.views.decorators.http import require_POST
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.decorators import login_required
from django.shortcuts import render, redirect, get_object_or_404
from .models import Review, Comment
from .forms import ReviewForm, CommentForm
from django.contrib import messages
import json
import logging
logger = logging.getLogger(__name__)


def reviews(request):
    return render(request, 'reviews/reviews.html')
    """
    Deletes an existing comment on a review.

    Parameters:
        request (HttpRequest): The HTTP request to delete the comment.
        review_id (int): The ID of the review to which the comment belongs.
        comment_id (int): The ID of the comment being deleted.

    Returns:
        JsonResponse: A JSON response with the success or failure message.
    """
    if request.method == 'DELETE':
        try:
            # Fetch the comment
            comment = Comment.objects.get(id=comment_id, review_id=review_id)
            logger.info(f"Fetched comment ID {comment_id}. Comment belongs to review ID {review_id} and user {comment.user.username}")

            # Check if the user is the owner of the comment
            if comment.user != request.user:
                logger.warning(f"User {request.user.username} is not authorized to delete comment ID {comment_id}.")
                return JsonResponse({'error': 'You are not authorized to delete this comment.'}, status=403)

            # Delete the comment
            comment.delete()
            logger.info(f"Comment ID {comment_id} deleted successfully.")
            return JsonResponse({'message': 'Comment deleted successfully.'}, status=200)

        except Comment.DoesNotExist:
            logger.error(f"Comment ID {comment_id} under review ID {review_id} does not exist.")
            return JsonResponse({'error': 'Comment not found.'}, status=404)

        except Exception as e:
            logger.exception(f"An unexpected error occurred while deleting comment ID {comment_id} under review ID {review_id}.")
            return JsonResponse({'error': str(e)}, status=500)

    logger.warning(f"Invalid request method: {request.method} for deleting comment ID {comment_id}.")
    return JsonResponse({'error': 'Invalid request method.'}, status=405)

def edit_review(request, review_id):
    review = get_object_or_404(Review, id=review_id)
    print(f"Review ID: {review.id}, Seed: {review.seed}")
    if request.user != review.user:
        messages.error(request, "You don't have permission to edit this review.")
        return redirect('home:seed_detail', seed_id=review.seed.id)

    if request.method == 'POST':
        form = ReviewForm(request.POST, instance=review)
        if form.is_valid():
            updated_review = form.save(commit=False)
            updated_review.status = "pending"
            updated_review.save()
            messages.success(request, "Review updated successfully and is now awaiting approval.")
            return redirect('home:seed_detail', seed_id=review.seed.id)
    else:
        form = ReviewForm(instance=review)

    return render(request, 'edit_review.html', {'form': form, 'review':review})

def delete_review(request, review_id):
    review = get_object_or_404(Review, id=review_id)

    if request.user != review.user:
        messages.error(request, "You don't have permission to delete this review.")
        return redirect('home:seed_detail', seed_id=review.seed.id)

    review.delete()
    messages.success(request, "Review deleted successfully.")
    return redirect('home:seed_detail', seed_id=review.seed.id)

def edit_comment(request, comment_id):
    comment = get_object_or_404(Comment, id=comment_id)

    if request.user != comment.user:
        messages.error(request, "You don't have permission to edit this comment.")
        return redirect('home:seed_detail', seed_id=comment.review.seed.id)

    if request.method == 'POST':
        form = CommentForm(request.POST, instance=comment)
        if form.is_valid():
            comment.status = 'pending'
            form.save()
            messages.success(request, "Comment updated successfully.")
            return redirect('home:seed_detail', seed_id=comment.review.seed.id)
    else:
        form = CommentForm(instance=comment)

    return render(request, 'edit_comment.html', {'form': form,'comment': comment})

def delete_comment(request, comment_id):
    comment = get_object_or_404(Comment, id=comment_id)

    if request.user != comment.user:
        messages.error(request, "You don't have permission to delete this comment.")
        return redirect('home:seed_detail', seed_id=comment.review.seed.id)

    comment.delete()
    messages.success(request, "Comment deleted successfully.")
    return redirect('home:seed_detail', seed_id=comment.review.seed.id)


