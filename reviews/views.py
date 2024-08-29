from django.shortcuts import get_object_or_404, redirect, render
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .models import Review, Comment
from .forms import ReviewForm, CommentForm, EditReviewForm
from seeds.models import Seed
import logging

logger = logging.getLogger(__name__)

@login_required
def handle_form_submission(request, form, instance, success_message, redirect_url, log_message, **redirect_kwargs):
    if form.is_valid():
        try:
            instance.status = 'pending'
            instance.user = request.user
            instance.save()
            messages.success(request, success_message)
            return redirect(redirect_url, **redirect_kwargs)
        except Exception as e:
            logger.error(f"{log_message}: {e}")
            messages.error(request, "An error occurred.")
    else:
        messages.error(request, "There was an error with your submission.")
    return redirect(redirect_url, **redirect_kwargs)

@login_required
def submit_review(request):
    form = ReviewForm(request.POST)
    seed_id = request.POST.get('seed_id')
    seed = get_object_or_404(Seed, id=seed_id)
    review = form.save(commit=False)
    review.seed = seed
    return handle_form_submission(
        request, form, review, "Review submitted and is awaiting approval.",
        'seed_details', f"Error submitting review for seed {seed_id}",
        id=seed.id
    )


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
        try:
            comment.save()
            messages.success(request, "Comment added successfully and is pending approval.")
        except Exception as e:
            logger.error(f"Error submitting comment for review {review_id}: {e}")
            messages.error(request, "An error occurred while submitting your comment.")
        return redirect('seed_details', id=review.seed.id)
    return redirect('seed_details', id=review.seed.id)



@login_required
def edit_review(request, review_id):
    review = get_object_or_404(Review, id=review_id)
    if request.user != review.user:
        return HttpResponseForbidden("You do not have permission to edit this review.")
    
    if request.method == 'POST':
        form = EditReviewForm(request.POST, instance=review)
        if form.is_valid():
            review.status = 'pending'
            form.save()
            messages.success(request, "Your review has been updated and is pending approval.")
            return redirect('seed_details', id=review.seed.id)
        else:
            return render(request, 'reviews/edit_review.html', {'form': form, 'review': review})
    else:
        form = EditReviewForm(instance=review)
        messages.error(request, "There was an error with your submission. Please check the form and try again.")
        return render(request, 'reviews/edit_review.html', {'form': form, 'review': review})

@login_required
def delete_review(request, review_id):
    review = get_object_or_404(Review, id=review_id, user=request.user)
    if request.method == 'POST':
        try:
            review.delete()
            messages.success(request, "Review deleted successfully.")
        except Exception as e:
            logger.error(f"Error deleting review: {e}")
            messages.error(request, "An error occurred while deleting your review.")
    return redirect('seed_details', id=review.seed.id)

@login_required
def edit_comment(request, comment_id):
    comment = get_object_or_404(Comment, id=comment_id, user=request.user)
    form = CommentForm(request.POST or None, instance=comment)
    return handle_form_submission(
        request, form, comment, "Comment updated successfully.",
        'seed_details', f"Error updating comment {comment_id}",
        id=comment.review.seed.id
    )

@login_required
def delete_comment(request, comment_id):
    comment = get_object_or_404(Comment, id=comment_id, user=request.user)
    if request.method == 'POST':
        try:
            comment.delete()
            messages.success(request, "Comment deleted successfully.")
        except Exception as e:
            logger.error(f"Error deleting comment: {e}")
            messages.error(request, "An error occurred while deleting your comment.")
    return redirect('seed_details', id=comment.review.seed.id)
