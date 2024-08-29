from django.shortcuts import render, get_object_or_404, redirect
from .models import Seed
from .forms import SearchForm
from reviews.models import Review, Comment
from reviews.forms import ReviewForm, CommentForm
from django.core.paginator import Paginator
from django.contrib import messages
from django.db.models import Prefetch



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

    if request.method == 'POST':
        quantity = int(request.POST.get('quantity', 1))
        if quantity > 0:
            # Logic to add the seed to the cart with the specified quantity
            cart_item, created = CartItem.objects.get_or_create(
                seed=seed,
                user=request.user,  # Assuming you have user-specific carts
                defaults={'quantity': quantity}
            )
            if not created:
                cart_item.quantity += quantity
                cart_item.save()

            # Store item details in session
            request.session['last_added_item'] = {
                'item_name': seed.name,
                'item_price': str(seed.calculate_discounted_price()),
                'item_quantity': quantity
            }

            # Add a success message
            messages.success(request, "Item added to cart", extra_tags='item_added')
            
            return redirect('cart')  # Redirect to the cart or another page

    reviews = seed.reviews.filter(status='approved').order_by('-created_at').prefetch_related(
        Prefetch('comments', queryset=Comment.objects.filter(status='approved').order_by('-created_at'))
    )

    context = {
        'seed': seed,
        'reviews': reviews
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