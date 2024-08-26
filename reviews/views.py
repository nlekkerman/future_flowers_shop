from django.shortcuts import get_object_or_404, redirect, render
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .models import Review, Comment
from .forms import ReviewForm, CommentForm,EditReviewForm
from seeds.models import Seed
import logging

logger = logging.getLogger(__name__)

@login_required
def submit_review(request):
    if request.method == 'POST':
        form = ReviewForm(request.POST)
        if form.is_valid():
            try:
                seed_id = request.POST.get('seed_id')
                seed = get_object_or_404(Seed, id=seed_id)
                review = form.save(commit=False)
                review.seed = seed
                review.user = request.user
                review.is_approved = False
                review.save()
                messages.success(request, "Review submitted and is awaiting approval.")
                return redirect('seed_details', id=seed.id)
            except Seed.DoesNotExist:
                logger.error(f"Seed with id {seed_id} does not exist.")
                messages.error(request, "Seed does not exist.")
            except Exception as e:
                logger.error(f"Error submitting review: {e}")
                messages.error(request, "An error occurred while submitting your review.")
        else:
            logger.debug(f"Review form is not valid: {form.errors}")
            messages.error(request, "There was an error with your submission.")
    else:
        logger.debug("Request method was not POST.")
    return render(request, 'reviews/edit_review.html', {'form': form, 'review': review})

@login_required
def submit_comment(request):
    if request.method == 'POST':
        form = CommentForm(request.POST)
        if form.is_valid():
            try:
                review_id = request.POST.get('review_id')
                review = get_object_or_404(Review, id=review_id)
                comment = form.save(commit=False)
                comment.review = review
                comment.user = request.user
                comment.save()
                messages.success(request, "Comment added successfully.")
                return redirect('seed_details', id=review.seed.id)
            except Review.DoesNotExist:
                logger.error(f"Review with id {review_id} does not exist.")
                messages.error(request, "Review does not exist.")
            except Exception as e:
                logger.error(f"Error submitting comment: {e}")
                messages.error(request, "An error occurred while submitting your comment.")
        else:
            logger.debug(f"Comment form is not valid: {form.errors}")
            messages.error(request, "There was an error with your submission.")
    else:
        logger.debug("Request method was not POST.")
    return redirect('home')


@login_required
def edit_review(request, review_id):
    review = get_object_or_404(Review, id=review_id)
    
    if review.user != request.user:
        return HttpResponseForbidden("You do not have permission to edit this review.")
    
    if request.method == 'POST':
        form = EditReviewForm(request.POST, instance=review)
        if form.is_valid():
            try:
                # No need to manually get and set the seed here again
                # because the `form.save()` should handle this

                edited_review = form.save(commit=False)
                edited_review.is_approved = False  # Ensure the review remains unapproved if editing
                
                edited_review.save()
                messages.success(request, "Review updated successfully. It is now awaiting approval.")
                return redirect('seed_details', id=review.seed.id)  # Redirect to the seed details page
            except Seed.DoesNotExist:
                logger.error(f"Seed with id {review.seed.id} does not exist.")
                messages.error(request, "Seed does not exist.")
            except Exception as e:
                logger.error(f"Error updating review: {e}")
                messages.error(request, "An error occurred while updating your review.")
        else:
            logger.debug(f"Edit review form is not valid: {form.errors}")
            messages.error(request, "There was an error with your submission.")
    else:
        form = EditReviewForm(instance=review)
    
    return render(request, 'reviews/edit_review.html', {'form': form, 'review': review})


@login_required
def delete_review(request, review_id):
    review = get_object_or_404(Review, id=review_id, user=request.user)
    if request.method == 'POST':
        try:
            seed_id = review.seed.id
            review.delete()
            messages.success(request, "Review deleted successfully.")
            return redirect('seed_details', id=seed_id)
        except Exception as e:
            logger.error(f"Error deleting review: {e}")
            messages.error(request, "An error occurred while deleting your review.")
    return render(request, 'reviews/delete_review.html', {'review': review})

@login_required
def edit_comment(request, comment_id):
    comment = get_object_or_404(Comment, id=comment_id, user=request.user)
    if request.method == 'POST':
        form = CommentForm(request.POST, instance=comment)
        if form.is_valid():
            try:
                form.save()
                messages.success(request, "Comment updated successfully.")
                return redirect('seed_details', id=comment.review.seed.id)
            except Exception as e:
                logger.error(f"Error updating comment: {e}")
                messages.error(request, "An error occurred while updating your comment.")
        else:
            messages.error(request, "There was an error with your submission.")
    else:
        form = CommentForm(instance=comment)
    return render(request, 'reviews/edit_comment.html', {'form': form, 'comment': comment})

@login_required
def delete_comment(request, comment_id):
    comment = get_object_or_404(Comment, id=comment_id, user=request.user)
    if request.method == 'POST':
        try:
            seed_id = comment.review.seed.id
            comment.delete()
            messages.success(request, "Comment deleted successfully.")
            return redirect('seed_details', id=seed_id)
        except Exception as e:
            logger.error(f"Error deleting comment: {e}")
            messages.error(request, "An error occurred while deleting your comment.")
    return render(request, 'reviews/delete_comment.html', {'comment': comment})
