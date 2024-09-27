from django.http import JsonResponse
from django.views.decorators.http import require_POST
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.decorators import login_required
from .models import Review
from .forms import ReviewForm

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