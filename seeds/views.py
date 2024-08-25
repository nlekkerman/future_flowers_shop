from django.shortcuts import render, get_object_or_404, redirect
from .models import Seed
from .forms import SearchForm
from reviews.models import Review, Comment
from reviews.forms import ReviewForm, CommentForm
from django.core.paginator import Paginator
from django.contrib import messages



def seed_list(request):
    category = request.GET.get('category')
    sort = request.GET.get('sort')
    page_number = request.GET.get('page', 1)
    
    seeds = Seed.objects.all()
    
    if category:
        seeds = seeds.filter(category=category)
    
    if sort == 'price_asc':
        seeds = seeds.order_by('price')
    elif sort == 'price_desc':
        seeds = seeds.order_by('-price')
    elif sort == 'latest':
        seeds = seeds.order_by('-created_at')  # Assuming there's a 'created_at' field
    elif sort == 'discount':
        seeds = seeds.filter(discount=True).order_by('-discount')

    # Pagination
    paginator = Paginator(seeds, 9)  # Show 9 seeds per page
    page_obj = paginator.get_page(page_number)
        
    
    context = {
        'page_obj': page_obj,
        'category': category,
        'sort': sort,
    }
    
    return render(request, 'seeds/seeds.html', context)

def seed_details(request, id):
    seed = get_object_or_404(Seed, id=id)
    review_form = ReviewForm()
    comment_form = CommentForm()
    
    if request.method == 'POST':
        if request.user.is_authenticated:
            if 'submit_review' in request.POST:
                review_form = ReviewForm(request.POST)
                if review_form.is_valid():
                    review = review_form.save(commit=False)
                    review.seed = seed
                    review.user = request.user
                    review.is_approved = False  # Requires admin approval
                    review.save()
                    messages.success(request, "Review submitted and is awaiting approval.")
                    return redirect('seed_details', id=seed.id)
            
            elif 'submit_comment' in request.POST:
                comment_form = CommentForm(request.POST)
                if comment_form.is_valid():
                    review_id = request.POST.get('review_id')
                    review = get_object_or_404(Review, id=review_id)
                    comment = comment_form.save(commit=False)
                    comment.review = review
                    comment.user = request.user
                    comment.save()
                    messages.success(request, "Comment added successfully.")
                    return redirect('seed_details', id=seed.id)
        else:
            messages.error(request, "You must be logged in to leave a review or comment.")
            return redirect('login')  # Redirect to the login page if not authenticated

    context = {
        'seed': seed,
        'review_form': review_form,
        'comment_form': comment_form,
        'reviews': seed.reviews.filter(is_approved=True),
    }
    
    return render(request, 'seeds/seed_details.html', context)

def search_results(request):
    form = SearchForm(request.GET or None)
    query = form.data.get('query', '')

    if query:
        seeds = Seed.objects.filter(
            name__icontains=query
        ) | Seed.objects.filter(
            scientific_name__icontains=query
        ) | Seed.objects.filter(
            description__icontains=query
        )
    else:
        seeds = Seed.objects.none()

    return render(request, 'seeds/search_results.html', {
        'seeds': seeds,
        'form': form,
        'query': query
    })