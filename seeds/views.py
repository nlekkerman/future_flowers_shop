from django.shortcuts import render, get_object_or_404, redirect
from .models import Seed
from .forms import SearchForm, SeedForm
from reviews.models import Review, Comment
from reviews.forms import ReviewForm, CommentForm
from django.core.paginator import Paginator
from django.contrib import messages
from django.db.models import Prefetch,F, ExpressionWrapper, DecimalField
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_POST
from cart.models import Cart, CartItem
from decimal import Decimal
from django.http import JsonResponse
import logging


# Set up logging configuration
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)  # Adjust as needed
handler = logging.StreamHandler()  # Use FileHandler to log to a file if needed
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
handler.setFormatter(formatter)
logger.addHandler(handler)
from django.http import JsonResponse
from .models import Seed

def seed_list_api(request):
    if request.method == 'GET':
        # Fetch seeds that are not marked as deleted
        seeds = Seed.objects.filter(deleted=False)  # Adjust as needed

        # Prepare the response data
        seed_data = []
        for seed in seeds:
            seed_data.append({
                'id': seed.id,
                'name': seed.name,
                'scientific_name': seed.scientific_name,
                'description': seed.description,
                'planting_months_from': seed.planting_months_from,
                'planting_months_to': seed.planting_months_to,
                'flowering_months_from': seed.flowering_months_from,
                'flowering_months_to': seed.flowering_months_to,
                'category': seed.category,
                'height_from': str(seed.height_from),  # Convert to string for JSON serialization
                'height_to': str(seed.height_to),      # Convert to string for JSON serialization
                'sun_preference': seed.sun_preference,
                'price': str(seed.price),               # Convert to string for JSON serialization
                'discount': str(seed.discount),         # Convert to string for JSON serialization
                'is_in_stock': seed.is_in_stock,
                'created_at': seed.created_at.isoformat(),  # Use ISO format for datetime
                'last_modified': seed.last_modified.isoformat(),  # Use ISO format for datetime
                'image': seed.image.url if seed.image else None,  # Get image URL
            })

        return JsonResponse({'success': True, 'seeds': seed_data})

    return JsonResponse({'success': False, 'error': 'Invalid request method'}, status=405)

def edit_seed_view(request, id):
    seed = get_object_or_404(Seed, id=id)

    if request.method == 'POST':
        form = SeedForm(request.POST, request.FILES, instance=seed)
        if form.is_valid():
            form.save()
            messages.success(request, 'Seed has been updated successfully!')
            return redirect('seeds:seed_list')  # Adjust redirect as needed
    else:
        form = SeedForm(instance=seed)

    return render(request, 'seeds/edit_seed.html', {'form': form})
def delete_seed_view(request, id):
    if request.method == 'DELETE':
        seed = get_object_or_404(Seed, id=id)
        seed.delete()
        return JsonResponse({'success': True})

    return JsonResponse({'success': False}, status=405)


def seeds_view(request):
    show_seeds = request.GET.get('show_seeds', 'false') == 'true'
    return render(request, 'seeds.html', {'show_seeds': show_seeds})

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

   

    context = {
        'seed': seed,
    }
    
    return render(request, 'seeds/seed_details.html', context)


def search_results(request):
    # Render the search_results.html template
    return render(request, 'seeds/search_results.html')


def create_seed_view(request):
    if request.method == 'POST':
        logger.debug("POST data received: %s", request.POST)  # Log POST data
        
        form = SeedForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()
            logger.info("Seed added successfully: %s", form.cleaned_data)  # Log successful form save
            messages.success(request, 'Seed added successfully!') 
            return redirect('admin_dashboard')  # Redirect to admin page after successful save
        else:
            logger.warning("Form submission errors: %s", form.errors)  # Log form errors

    else:
        form = SeedForm()

    # No need to redirect; instead return to the same page, assuming the context is set in the view
    return redirect('admin_dashboard') 

def edit_seed_view(request, id):
    # Retrieve the seed instance by ID
    seed = get_object_or_404(Seed, id=id)

    if request.method == 'POST':
        # Bind the form to the submitted data and the instance of the seed
        form = SeedForm(request.POST, request.FILES, instance=seed)

        if form.is_valid():
            form.save()
            return redirect('admin_dashboard')  # Redirect to the seed list after successful edit
        else:
            messages.error(request, 'There was an error with your submission.')
    else:
        form = SeedForm(instance=seed)  # Create a form instance with the existing seed data

    return redirect('admin_dashboard')

    