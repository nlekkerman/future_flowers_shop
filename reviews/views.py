from django.http import JsonResponse
from django.views.decorators.http import require_POST
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.decorators import login_required
from .models import Review, Comment
from .forms import ReviewForm
import json
import logging
logger = logging.getLogger(__name__)


@login_required
@require_POST
def write_review(request):
    form = ReviewForm(request.POST)
    if form.is_valid():
        review = form.save(commit=False)
        review.user = request.user
        review.status = 'pending'
        review.save()
        return JsonResponse({
            'success': True,
            'message': 'Review submitted successfully and is pending approval.'
        })
    return JsonResponse({
        'success': False,
        'message': 'Invalid form submission',
        'errors': form.errors
    })


@login_required
def fetch_reviews(request):
    # Fetch all approved reviews with related approved comments
    reviews = Review.objects.filter(status='approved', deleted=False).prefetch_related('comments')

    # Prepare the data in JSON format
    data = []
    for review in reviews:
        comments = review.comments.filter(status='approved', deleted=False)
        data.append({
            'id': review.id,  # Add review ID
            'user_id': review.user.id,  # Add user ID
            'user': review.user.username,
            'rating': review.rating,
            'comment': review.comment,
            'created_at': review.created_at.strftime('%Y-%m-%d %H:%M:%S'),
            'comments': [
                {   
                    'id': comment.id,
                    'user': comment.user.username,
                    'text': comment.text,
                    'created_at': comment.created_at.strftime('%Y-%m-%d %H:%M:%S')
                } for comment in comments
            ]
        })

    return JsonResponse({'reviews': data})


@csrf_exempt  # Note: Consider adding proper CSRF protection
@login_required
def update_review(request):
    if request.method == 'POST':
        review_id = request.POST.get('review_id')
        rating = request.POST.get('rating')
        comment = request.POST.get('comment')

        try:
            review = Review.objects.get(id=review_id, user=request.user)
            review.rating = rating
            review.comment = comment
            review.status = 'pending'
            review.save()
            return JsonResponse({'message': 'Review updated successfully.'}, status=200)
        except Review.DoesNotExist:
            return JsonResponse({'error': 'Review not found.'}, status=404)

    return JsonResponse({'error': 'Invalid request method.'}, status=400)

@csrf_exempt  # Note: Consider adding proper CSRF protection
@login_required
def delete_review(request, review_id):
    try:
        review = Review.objects.get(id=review_id, user=request.user)
        review.delete()
        return JsonResponse({'message': 'Review deleted successfully.'}, status=200)
    except Review.DoesNotExist:
        return JsonResponse({'error': 'Review not found.'}, status=404)


@login_required
def leave_comment(request, review_id):
    if request.method == 'POST':
        try:
            # Parse the incoming JSON data
            data = json.loads(request.body)
            comment_text = data.get('text')

            # Validate comment text
            if not comment_text:
                return JsonResponse({'error': 'Comment text is required.'}, status=400)

            # Fetch the review and create a comment
            review = Review.objects.get(id=review_id)

            # Create the comment
            comment = Comment.objects.create(
                review=review,
                user=request.user,
                text=comment_text
            )

            # Log the comment ID and associated user information
            logger.info(f'Comment created successfully: ID={comment.id}, User={comment.user.username}, Review ID={review_id}')

            # Create a response object with the comment data
            response_data = {
                'message': 'Comment added successfully.',
                'comment': {
                    'id': comment.id,
                    'user': comment.user.username,  # Assuming user has a username field
                    'text': comment.text,
                    'created_at': comment.created_at.isoformat()  # Format for JSON response
                }
            }
            return JsonResponse(response_data, status=201)

        except Review.DoesNotExist:
            logger.error(f'Review with id {review_id} does not exist.')
            return JsonResponse({'error': 'Review not found.'}, status=404)

        except json.JSONDecodeError:
            logger.error('Invalid JSON received.')
            return JsonResponse({'error': 'Invalid JSON data.'}, status=400)

        except Exception as e:
            logger.exception("An error occurred while leaving a comment.")
            return JsonResponse({'error': str(e)}, status=500)

    return JsonResponse({'error': 'Invalid request method.'}, status=405)




@login_required
def update_comment(request, review_id, comment_id):
    logger.info(f"Received request to update comment with ID: {comment_id} for review ID: {review_id}. User: {request.user.username}")

    if request.method == 'PUT':  # Check for PUT request
        try:
            # Parse the incoming JSON data
            data = json.loads(request.body)
            logger.debug(f"Incoming data for updating comment ID {comment_id}: {data}")

            comment_text = data.get('text')

            # Validate comment text
            if not comment_text:
                logger.warning(f"Comment text is missing for comment ID: {comment_id}.")
                return JsonResponse({'error': 'Comment text is required.'}, status=400)

            # Fetch the comment and update its text
            comment = Comment.objects.get(id=comment_id)
            logger.info(f"Fetched comment: ID={comment.id}, Current text='{comment.text}'")

            # Check if the user is the owner of the comment
            if comment.user != request.user:
                logger.error(f"User {request.user.username} is not authorized to edit comment ID: {comment_id}.")
                return JsonResponse({'error': 'You are not authorized to edit this comment.'}, status=403)

            # Optionally, you can also verify if the comment belongs to the review
            if comment.review.id != review_id:
                logger.error(f"Comment ID {comment_id} does not belong to Review ID {review_id}.")
                return JsonResponse({'error': 'Comment does not belong to the specified review.'}, status=400)

            # Update the comment text
            comment.text = comment_text
            comment.status = 'pending'
            comment.save()
            logger.info(f"Updated comment ID={comment.id}. New text='{comment.text}'")

            # Create a response object with the updated comment data
            response_data = {
                'message': 'Comment updated successfully.',
                'comment': {
                    'id': comment.id,
                    'user': comment.user.username,
                    'text': comment.text,
                    'created_at': comment.created_at.isoformat()  # Format for JSON response
                }
            }
            return JsonResponse(response_data, status=200)

        except Comment.DoesNotExist:
            logger.error(f'Comment with ID {comment_id} does not exist.')
            return JsonResponse({'error': 'Comment not found.'}, status=404)

        except json.JSONDecodeError:
            logger.error('Invalid JSON received.')
            return JsonResponse({'error': 'Invalid JSON data.'}, status=400)

        except Exception as e:
            logger.exception("An error occurred while updating the comment.")
            return JsonResponse({'error': str(e)}, status=500)

    logger.warning(f"Invalid request method received: {request.method} for comment ID: {comment_id}.")
    return JsonResponse({'error': 'Invalid request method.'}, status=405)


@login_required
def delete_comment(request, review_id, comment_id):
    logger.info(f"Delete request received for comment ID {comment_id} under review ID {review_id} by user {request.user.username}")

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