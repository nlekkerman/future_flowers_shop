from django.shortcuts import render, redirect, get_object_or_404
from seeds.models import Seed
import random
import logging
from django.db.models import Q, Avg
from django.contrib import messages
from reviews.models import Review, Comment
from reviews.forms import ReviewForm, CommentForm
from django.core.paginator import Paginator

# Configure the logger
logger = logging.getLogger(__name__)


def home(request):
    """
    Handles displaying the home page with a list of seeds. 
    It allows users to filter, search, and sort seeds.
    - Retrieves search query, category, and filter option from the GET request.
    - Filters seeds based on the search query, category, and any other selected filter option.
    - Displays seeds with their details such as name, price, and description.
    - Allows sorting seeds by price, discount, or date based on the selected filter.
    - Includes pagination to display a limited number of seeds per page.
    - Calculates and displays average ratings for each seed based on user reviews.
    """
    
    # Get filters from GET request
    search_query = request.GET.get('search', '')
    category = request.GET.get('category', '')
    filter_option = request.GET.get('filter', '')

    # Start with all seeds
    seeds = Seed.objects.all()

    for seed in seeds:
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
        seeds = seeds.order_by('-price')
    elif filter_option == 'low_to_high':
        seeds = seeds.order_by('price')
    elif filter_option == 'newest':
        seeds = seeds.order_by('-created_at')
    elif filter_option == 'oldest':
        seeds = seeds.order_by('created_at')
        
     # Add average rating to each seed
    for seed in seeds:
        reviews = Review.objects.filter(seed=seed, status='approved')
        if reviews.exists():
            # Calculate the average rating for each seed
            avg_rating = reviews.aggregate(Avg('rating'))['rating__avg']
            seed.avg_rating = avg_rating
        else:
            seed.avg_rating = None

    # Pagination
    paginator = Paginator(seeds, 6)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    # Return the sorted and filtered seeds to the template
    context = {
        'seeds': page_obj,
        'search_query': search_query,
        'category': category,
        'filter_option': filter_option,
    }

    return render(request, 'home/home.html', context)


def seed_detail(request, seed_id):
    """
    Handles displaying the details of a specific seed, including its reviews and comments.
    - Retrieves the seed object based on the seed ID.
    - Fetches approved reviews related to the seed and calculates the average rating.
    - Retrieves approved comments for each review.
    - Displays the review form and comment form for user submissions.
    - Handles comment and review submission via POST requests.
    - Provides success and error messages based on the submission results.
    - Displays the list of reviews, comments, and the average rating for the seed.
    """

    seed = get_object_or_404(Seed, id=seed_id)
    reviews = Review.objects.filter(seed=seed, status='approved').select_related('user')
    
    # Calculate average rating from approved reviews
    seed.avg_rating = reviews.aggregate(Avg('rating'))['rating__avg']
    seed.avg_rating = round(seed.avg_rating, 1) if seed.avg_rating else None
    
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

