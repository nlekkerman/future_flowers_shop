from django.shortcuts import render, get_object_or_404, redirect
from .models import Seed
from .forms import SearchForm
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

@csrf_exempt
@require_POST
def add_to_cart(request):
    try:
        seed_id = request.POST.get('seed_id')
        quantity = int(request.POST.get('quantity', 1))

        if quantity <= 0:
            return JsonResponse({'error': 'Quantity must be greater than zero.'}, status=400)

        if request.user.is_authenticated:
            cart, created = Cart.objects.get_or_create(user=request.user, defaults={'session_id': None})
        else:
            session_key = request.session.session_key
            if not session_key:
                request.session.create()
                session_key = request.session.session_key
            cart, created = Cart.objects.get_or_create(session_id=session_key, defaults={'user': None})

        seed = Seed.objects.get(id=seed_id)
        cart_item, created = CartItem.objects.get_or_create(cart=cart, seed=seed, defaults={'quantity': 0})

        if not created:
            cart_item.quantity += quantity
        else:
            cart_item.quantity = quantity
        cart_item.save()

        total_price = cart.get_total_price()
        total_discount = cart.get_total_discount()
        delivery_cost = cart.get_delivery_cost()
        grand_total = cart.get_grand_total()

        return JsonResponse({
            'cart_item_id': cart_item.id,
            'total_price': str(total_price),
            'total_discount': str(total_discount),
            'delivery_cost': str(delivery_cost),
            'grand_total': str(grand_total),
            'quantity': cart_item.quantity
        })

    except Seed.DoesNotExist:
        return JsonResponse({'error': 'Seed not found.'}, status=404)
    except Cart.DoesNotExist:
        return JsonResponse({'error': 'Cart not found.'}, status=404)
    except Exception as e:
        return JsonResponse({'error': f'An unexpected error occurred: {str(e)}'}, status=500)
    try:
        seed_id = request.POST.get('seed_id')
        quantity = int(request.POST.get('quantity', 1))

        if quantity <= 0:
            return JsonResponse({'error': 'Quantity must be greater than zero.'}, status=400)

        if request.user.is_authenticated:
            cart, created = Cart.objects.get_or_create(user=request.user, defaults={'session_id': None})
        else:
            session_key = request.session.session_key
            if not session_key:
                request.session.create()
                session_key = request.session.session_key
            cart, created = Cart.objects.get_or_create(session_id=session_key, defaults={'user': None})

        seed = Seed.objects.get(id=seed_id)
        cart_item, created = CartItem.objects.get_or_create(cart=cart, seed=seed, defaults={'quantity': 0})

        if not created:
            cart_item.quantity += quantity
            cart_item.save()

        total_price = cart.get_total_price()
        total_discount = cart.get_total_discount()
        delivery_cost = cart.get_delivery_cost()
        grand_total = cart.get_grand_total()

        return JsonResponse({
            'cart_item_id': cart_item.id,
            'total_price': str(total_price),
            'total_discount': str(total_discount),
            'delivery_cost': str(delivery_cost),
            'grand_total': str(grand_total),
            'quantity': cart_item.quantity
        })

    except Seed.DoesNotExist:
        return JsonResponse({'error': 'Seed not found.'}, status=404)
    except Cart.DoesNotExist:
        return JsonResponse({'error': 'Cart not found.'}, status=404)
    except Exception as e:
        return JsonResponse({'error': f'An unexpected error occurred: {str(e)}'}, status=500)