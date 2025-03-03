from django.shortcuts import render, redirect, get_object_or_404
from seeds.models import Seed
import random
import logging
from django.db.models import Q, Avg
from django.contrib import messages
from reviews.models import Review, Comment
from reviews.forms import ReviewForm, CommentForm


# Configure the logger
logger = logging.getLogger(__name__)


def home(request):
    # Get filters from GET request
    search_query = request.GET.get('search', '')  # Search query
    category = request.GET.get('category', '')  # Category filter
    filter_option = request.GET.get('filter', '')  # Sorting/filtering option

    # Start with all seeds
    seeds = Seed.objects.all()

    for seed in seeds:
        # Add a range from 1 to the in_stock_number for each seed
        seed.range = range(1, seed.in_stock_number + 1)
    
    # Apply search filter if provided
    if search_query:
        seeds = seeds.filter(
            Q(name__icontains=search_query) |
            Q(description__icontains=search_query) |
            Q(scientific_name__icontains=search_query) |
            Q(category__icontains=search_query)
        )

    # Apply category filter if provided
    if category:
        seeds = seeds.filter(category=category)

    # Apply additional filter options (price or discount) based on the selected option
    if filter_option == 'discounted':
        seeds = seeds.filter(discount__gt=0)
    elif filter_option == 'high_to_low':
        seeds = seeds.order_by('-price')  # Sort by price, descending (high to low)
    elif filter_option == 'low_to_high':
        seeds = seeds.order_by('price')  # Sort by price, ascending (low to high)
    elif filter_option == 'newest':
        seeds = seeds.order_by('-created_at')  # Sort by creation date, descending (newest first)
    elif filter_option == 'oldest':
        seeds = seeds.order_by('created_at')  # Sort by creation date, ascending (oldest first)
        
     # Add average rating to each seed
    for seed in seeds:
        reviews = Review.objects.filter(seed=seed, status='approved')
        if reviews.exists():
            # Calculate the average rating for each seed
            avg_rating = reviews.aggregate(Avg('rating'))['rating__avg']
            seed.avg_rating = avg_rating  # Assign the average rating to the seed
        else:
            seed.avg_rating = None  # No rating if no reviews are present

    # Return the sorted and filtered seeds to the template
    context = {
        'seeds': seeds,
        'search_query': search_query,
        'category': category,
        'filter_option': filter_option,
    }

    return render(request, 'home/home.html', context)


def seed_detail(request, seed_id):
    seed = get_object_or_404(Seed, id=seed_id)
    reviews = Review.objects.filter(seed=seed, status='approved').select_related('user')
    # Get approved comments for each review
    approved_comments = Comment.objects.filter(review__in=reviews, status='approved')
    # Initialize the review form and comment form
    review_form = ReviewForm()
    comment_form = CommentForm()
    
    # Get the count of approved comments for each review
    for review in reviews:
        review.approved_comments_count = review.comments.filter(status='approved').count()
    
    for review in reviews:
        review.approved_comments_count_display = (
            f"{review.approved_comments_count} comment"
            if review.approved_comments_count == 1
            else f"{review.approved_comments_count} comments"
        )


    if request.method == 'POST':
        # Check if it's a comment submission or a review submission
        if 'comment_submit' in request.POST:
            # Handle comment submission
            comment_form = CommentForm(request.POST)
            if comment_form.is_valid():
                # Save the comment
                comment = comment_form.save(commit=False)
                review = get_object_or_404(Review, id=request.POST.get('review_id'))
                comment.review = review
                comment.user = request.user
                comment.save()
                messages.success(request, "Your comment has been submitted and is awaiting approval.")
            else:
            
                messages.error(request, "There was an error submitting your comment. Please try again.")
                return redirect('home:seed_detail', seed_id=seed.id)
        elif 'review_submit' in request.POST:
            # Handle review submission
            review_form = ReviewForm(request.POST)
            if review_form.is_valid():
                # Save the review
                review = review_form.save(commit=False)
                review.seed = seed
                review.user = request.user
                review.save()
                messages.success(request, "Your review has been submitted and is awaiting approval.")
                
                return redirect('home:seed_detail', seed_id=seed.id)  # Redirect to the same page
            else:
                # Error message if review form is invalid
                messages.error(request, "There was an error submitting your review. Please try again.")
                
    return render(request, "home/seed_detail.html", {
        'seed': seed,
        'reviews': reviews,
        'approved_comments': approved_comments,
        'review_form': review_form,
        'comment_form': comment_form,
    })
    """
    Adds a seed to the cart. If the cart does not exist, it creates a new session cart.
    This function ensures that only serializable data is stored in the session.
    """
    # Get the seed object
    try:
        seed = Seed.objects.get(id=seed_id)
    except Seed.DoesNotExist:
        messages.error(request, "Seed not found.")
        return redirect('home:home')

    quantity = int(request.POST.get('quantity', 1))

    # Ensure quantity doesn't exceed available stock
    if quantity > seed.in_stock_number:
        messages.error(request, f"Only {seed.in_stock_number} items available.")
        return redirect('home:home')

    # Get the cart from the session or create an empty one
    cart = request.session.get('cart', {})

    # Store only primitive data types (no model instances!)
    if str(seed_id) in cart:
        cart[str(seed_id)]['quantity'] += quantity
    else:
        cart[str(seed_id)] = {
            'name': seed.name,
            'price': str(seed.price),
            'quantity': quantity
        }

    # Save the updated cart back into the session
    request.session['cart'] = cart
    request.session.modified = True  # Ensures session data is saved

    messages.success(request, f"{quantity} {seed.name} added to your cart.")
    return redirect('home:home')
    # Get the seed object from the database
    seed = Seed.objects.get(id=seed_id)

    # Get the quantity from the POST request (default to 1 if not provided)
    quantity = int(request.POST.get('quantity', 1))

    # Ensure that the quantity does not exceed available stock
    if quantity > seed.in_stock_number:
        messages.error(request, f"Only {seed.in_stock_number} items are available in stock.")
        return redirect('home:home')

    # Retrieve the cart from the session, or create an empty cart if it doesn't exist
    cart = request.session.get('cart', {})

    # Check if the seed is already in the cart, and update the quantity
    if seed_id in cart:
        cart[seed_id]['quantity'] += quantity
    else:
        cart[seed_id] = {
            'name': seed.name,
            'price': seed.price,
            'quantity': quantity,
        }

    # Save the updated cart to the session
    request.session['cart'] = cart

    # Provide feedback to the user
    messages.success(request, f"{quantity} {seed.name} added to your cart.")

    return redirect('home:home')

