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

def seed_list(request):
    """
    View to display a list of available seeds that are in stock.

    This view retrieves all seeds from the database that are marked as in stock 
    (i.e., `is_in_stock=True`). If seeds are found, they will be displayed to the 
    user. If no seeds are available, a message indicating "No seeds found!" 
    will be returned as a plain text response.

    Attributes:
        request (HttpRequest): The request object containing the details of the HTTP request.

    Returns:
        HttpResponse: 
            - A plain text message if no seeds are found.
            - A list of available seeds (additional logic may follow to render them).
    """
    seeds = Seed.objects.filter(is_in_stock=True)

    if not seeds.exists():
        return HttpResponse("No seeds found!", content_type="text/plain")

    return render(request, 'seeds/seeds.html', {'seeds': seeds})


# Create Seed View
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
        form = SeedForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()
            messages.success(request, 'Seed added successfully!')
            return redirect('custom_accounts:admin_dashboard')
        else:
            messages.error(request, 'There was an error with your submission.')

    else:
        form = SeedForm()

    return render(request, 'seeds/create_seed.html', {'form': form})


# Edit Seed View
def edit_seed_view(request, id):
    """
    View to edit an existing seed entry.

    Allows admins to update seed details via a form. On GET, it loads the form with existing data.
    On POST, it validates and updates the seed. If successful, it redirects with a success message;
    otherwise, it shows an error message.

    Attributes:
        request (HttpRequest): The request object.
        id (int): The ID of the seed being edited.

    Returns:
        HttpResponse: Renders the edit form (GET) or redirects to the admin dashboard (POST).
    """
    seed = get_object_or_404(Seed, id=id)

    if request.method == 'POST':
        form = SeedForm(request.POST, request.FILES, instance=seed)

        if form.is_valid():
            form.save()
            messages.success(request, "Seed updated successfully!")
            return redirect('custom_accounts:admin_dashboard')
        else:
            messages.error(request, "There was an error with your submission.")

    else:
        form = SeedForm(instance=seed)  # Pre-fill form with existing seed data

    return render(request, 'seeds/edit_seed.html', {'form': form, 'seed': seed})


# Delete Seed View
def delete_seed_view(request, id):
    """
    View to delete a seed entry.

    This view handles the deletion of a seed by its ID and redirects back to the admin dashboard.

    Attributes:
        request (HttpRequest): The request object containing the details of the HTTP request.
        id (int): The ID of the seed to be deleted.

    Returns:
        HttpResponseRedirect: Redirects to the admin dashboard after deletion.
    """
    if request.method == 'POST':  # Use POST instead of DELETE for deletion requests
        seed = get_object_or_404(Seed, id=id)
        seed.delete()
        messages.success(request, "Seed deleted successfully!")
        return redirect('admin_dashboard')

    return HttpResponseNotAllowed(['POST'])
    """
    View to delete a seed entry.

    This view handles the deletion of a seed by its ID and redirects back to the admin dashboard.

    Attributes:
        request (HttpRequest): The request object containing the details of the HTTP request.
        id (int): The ID of the seed to be deleted.

    Returns:
        HttpResponseRedirect: Redirects to the admin dashboard after deletion.
    """
    if request.method == 'POST':  # Use POST instead of DELETE
        seed = get_object_or_404(Seed, id=id)
        seed.delete()
        messages.success(request, "Seed deleted successfully!")
        return redirect('admin_dashboard')

    return HttpResponseNotAllowed(['POST'])