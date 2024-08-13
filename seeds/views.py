from django.shortcuts import render, get_object_or_404
from .models import Seed

def seed_list(request):
    category = request.GET.get('category')
    seeds = Seed.objects.all()

    if category:
        seeds = seeds.filter(category__iexact=category)

    context = {
        'seeds': seeds,
        'category': category,
    }
    return render(request, 'seeds/seeds.html', context)


def seed_details(request, id):
    seed = get_object_or_404(Seed, id=id)
    
    if request.method == 'POST':
        quantity = int(request.POST.get('quantity', 1))
        if quantity > 0:
            # Logic to add the seed to the cart with the specified quantity
            # (This would typically involve updating or creating a CartItem)
            cart_item, created = CartItem.objects.get_or_create(
                seed=seed,
                user=request.user,  # Assuming you have user-specific carts
                defaults={'quantity': quantity}
            )
            if not created:
                cart_item.quantity += quantity
                cart_item.save()
            
            return redirect('cart')  # Redirect to the cart or another page
    
    context = {
        'seed': seed,
    }
    return render(request, 'seeds/seeds_details.html', context)
    seed = get_object_or_404(Seed, id=id)
    return render(request, 'seeds/seeds_details.html', {'seed': seed})


def seed_details(request, id):
    seed = get_object_or_404(Seed, id=id)
    
    if request.method == 'POST':
        quantity = int(request.POST.get('quantity', 1))
        if quantity > 0:
            # Logic to add the seed to the cart with the specified quantity
            # (This would typically involve updating or creating a CartItem)
            cart_item, created = CartItem.objects.get_or_create(
                seed=seed,
                user=request.user,  # Assuming you have user-specific carts
                defaults={'quantity': quantity}
            )
            if not created:
                cart_item.quantity += quantity
                cart_item.save()
            
            return redirect('cart')  # Redirect to the cart or another page
    
    context = {
        'seed': seed,
    }
    return render(request, 'seeds/seed_details.html', context)
    seed = get_object_or_404(Seed, id=id)
    return render(request, 'seeds/seed_details.html', {'seed': seed})