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

logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG) 
handler = logging.StreamHandler() 
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
handler.setFormatter(formatter)
logger.addHandler(handler)
from django.http import JsonResponse
from .models import Seed

def seed_list_api(request):
    """
    API endpoint to retrieve a list of seeds.

    This view handles GET requests and returns a JSON response containing the details of all seeds 
    that are not marked as deleted.

    Attributes:
        request (HttpRequest): The request object containing the details of the HTTP request.
    
    Returns:
        JsonResponse: A JSON response with the success status and a list of seed details.
    
    """
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
    """
    View to edit an existing seed entry.

    This view allows admins to update the details of a specific seed. It retrieves the seed by its ID 
    and either displays a form to edit the seed details or processes the form data on POST submission.

    Attributes:
        request (HttpRequest): The request object containing the details of the HTTP request.
        id (int): The ID of the seed to be edited.

    Returns:
        HttpResponse: A response rendering the seed editing form, or a redirect to the seed list page 
        upon successful submission.
    """
    seed = get_object_or_404(Seed, id=id)

    if request.method == 'POST':
        form = SeedForm(request.POST, request.FILES, instance=seed)
        if form.is_valid():
            form.save()
            messages.success(request, 'Seed has been updated successfully!')
            return redirect('seeds:seed_list') 
    else:
        form = SeedForm(instance=seed)

    return render(request, 'seeds/edit_seed.html', {'form': form})
def delete_seed_view(request, id):
    """
    View to delete a seed entry.

    This view handles the deletion of a seed by its ID, which is passed as a URL parameter. 
    It only allows DELETE requests and returns a success or failure message in JSON format.

    Attributes:
        request (HttpRequest): The request object containing the details of the HTTP request.
        id (int): The ID of the seed to be deleted.

    Returns:
        JsonResponse: A JSON response indicating whether the seed was deleted successfully.

    """
    if request.method == 'DELETE':
        seed = get_object_or_404(Seed, id=id)
        seed.delete()
        return JsonResponse({'success': True})

    return JsonResponse({'success': False}, status=405)


def seeds_view(request):
    """
    View to display seeds based on a query parameter.

    This view renders a page that shows the list of seeds, based on the `show_seeds` query parameter. 
    If the parameter is 'true', the seeds are displayed; otherwise, they are hidden.

    Attributes:
        request (HttpRequest): The request object containing the details of the HTTP request.

    Returns:
        HttpResponse: A response rendering the seeds page with the 'show_seeds' context.
    """
    show_seeds = request.GET.get('show_seeds', 'false') == 'true'
    return render(request, 'seeds.html', {'show_seeds': show_seeds})

def seed_list(request):
    """
    View to display a paginated list of seeds.

    This view handles the retrieval of all seeds, with optional filtering by category and sorting by price, 
    date, or discount. The results are paginated with 9 seeds per page.

    Attributes:
        request (HttpRequest): The request object containing the details of the HTTP request.
        category (str): The optional category filter for seeds.
        sort (str): The optional sorting parameter ('price_asc', 'price_desc', 'latest', 'discount').
        page_number (int): The page number for pagination.

    Returns:
        HttpResponse: A response rendering the seeds list page with the filtered and sorted seeds.
    """
    category = request.GET.get('category')
    sort = request.GET.get('sort')
    page_number = request.GET.get('page', 1)
    
    seeds = Seed.objects.all().order_by('name')
    
    if category:
        seeds = seeds.filter(category=category)
    
    if sort == 'price_asc':
        seeds = seeds.order_by('price')
    elif sort == 'price_desc':
        seeds = seeds.order_by('-price')
    elif sort == 'latest':
        seeds = seeds.order_by('-created_at')
    elif sort == 'discount':
        seeds = seeds.filter(discount=True).order_by('-discount')

    paginator = Paginator(seeds, 9)
    page_obj = paginator.get_page(page_number)
        
    
    context = {
        'page_obj': page_obj,
        'category': category,
        'sort': sort,
    }
    
    return render(request, 'seeds/seeds.html', context)

def seed_details(request, id):
    """
    View to display details of a specific seed and add it to the cart.

    This view renders the details page of a seed, and if a POST request is made with a quantity, 
    the seed is added to the user's cart. The user is then redirected to the cart page.

    Attributes:
        request (HttpRequest): The request object containing the details of the HTTP request.
        id (int): The ID of the seed to be viewed.

    Returns:
        HttpResponse: A response rendering the seed details page, or a redirect to the cart after adding 
        the seed to the cart.
    """
    seed = get_object_or_404(Seed, id=id)

    if request.method == 'POST':
        quantity = int(request.POST.get('quantity', 1))
        if quantity > 0:
            # Logic to add the seed to the cart with the specified quantity
            cart_item, created = CartItem.objects.get_or_create(
                seed=seed,
                user=request.user, 
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
            
            return redirect('cart')

   

    context = {
        'seed': seed,
    }
    
    return render(request, 'seeds/seed_details.html', context)


def search_results(request):
    """
    View to render search results page.

    This view is responsible for displaying the search results page. It may include search logic, 
    but as written, it simply renders the `search_results.html` template.

    Attributes:
        request (HttpRequest): The request object containing the details of the HTTP request.

    Returns:
        HttpResponse: A response rendering the search results page.
    """
    return render(request, 'seeds/search_results.html')


def create_seed_view(request):
    """
    View to create a new seed entry.

    This view handles the creation of a new seed entry. It processes the form data submitted 
    via a POST request. If the form is valid, the new seed is saved, and the user is redirected 
    to the admin dashboard.

    Attributes:
        request (HttpRequest): The request object containing the details of the HTTP request.

    Returns:
        HttpResponse: A redirect to the admin dashboard after successful form submission.
    """
    if request.method == 'POST':
        logger.debug("POST data received: %s", request.POST)
        
        form = SeedForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()
            logger.info("Seed added successfully: %s", form.cleaned_data) 
            messages.success(request, 'Seed added successfully!') 
            return redirect('admin_dashboard') 
        else:
            logger.warning("Form submission errors: %s", form.errors)

    else:
        form = SeedForm()

  
    return redirect('admin_dashboard') 

def edit_seed_view(request, id):
    """
    View to edit an existing seed entry.

    This view allows admins to edit the details of a specific seed. It retrieves the seed by its ID 
    and processes the form data when a POST request is made. If the form is valid, the changes are saved, 
    and the user is redirected to the admin dashboard. If the form is invalid, an error message is displayed. 
    On GET requests, the existing seed data is pre-filled in the form.

    Attributes:
        request (HttpRequest): The request object containing the details of the HTTP request, including 
                                POST data or any additional context.
        id (int): The ID of the seed to be edited. This is used to retrieve the specific seed instance from the database.

    Returns:
        HttpResponse: A redirect to the admin dashboard after a successful form submission, 
                       or a response displaying error messages if the form is invalid.

    
    """
   
    seed = get_object_or_404(Seed, id=id)

    if request.method == 'POST':
        form = SeedForm(request.POST, request.FILES, instance=seed)

        if form.is_valid():
            form.save()
            return redirect('admin_dashboard')
        else:
            messages.error(request, 'There was an error with your submission.')
    else:
        form = SeedForm(instance=seed) 
    return redirect('admin_dashboard')

    