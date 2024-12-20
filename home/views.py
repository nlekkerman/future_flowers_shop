from django.shortcuts import render
from seeds.models import Seed  # Importing the Seed model from the 'seeds' app
import random

def home(request):
    # Fetch all seeds that are discounted
    discounted_seeds = Seed.objects.filter(deleted=False, discount__gt=0)
    
    # Select a random discounted seed
    random_discounted_seed = random.choice(discounted_seeds) if discounted_seeds else None
    
    # Fetch the latest added seed
    latest_seed = Seed.objects.filter(deleted=False).latest('created_at') if Seed.objects.filter(deleted=False).exists() else None
    
    # Calculate the discounted price in the view and pass it to the template
    if random_discounted_seed:
        discounted_price = random_discounted_seed.calculate_discounted_price()
    else:
        discounted_price = None

    # Render the home page with the random discounted seed and latest seed
    return render(request, 'home/home.html', {
        'random_discounted_seed': random_discounted_seed,
        'discounted_price': discounted_price,
        'latest_seed': latest_seed,
    })
