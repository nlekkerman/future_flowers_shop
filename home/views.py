from django.shortcuts import render
from seeds.models import Seed  # Importing the Seed model from the 'seeds' app
import random
import logging

# Configure the logger
logger = logging.getLogger(__name__)

def home(request):
    # Fetch all seeds that are discounted
    discounted_seeds = Seed.objects.filter(deleted=False, discount__gt=0)
    
    # Select a random discounted seed
    random_discounted_seed = random.choice(discounted_seeds) if discounted_seeds else None
    
    # Fetch the latest added seed
    latest_seed = None
    try:
        if Seed.objects.filter(deleted=False).exists():
            latest_seed = Seed.objects.filter(deleted=False).latest('created_at')
            logger.info(f"Latest seed retrieved: {latest_seed}")
            if latest_seed.image:
                logger.info(f"Latest seed image URL: {latest_seed.image.url}")
            else:
                logger.warning("Latest seed does not have an associated image.")
        else:
            logger.info("No seeds found in the database.")
    except Exception as e:
        logger.error(f"Error fetching the latest seed: {e}")
    
    # Calculate the discounted price in the view and pass it to the template
    if random_discounted_seed:
        discounted_price = random_discounted_seed.calculate_discounted_price()
        logger.info(f"Random discounted seed: {random_discounted_seed}, Discounted price: {discounted_price}")
    else:
        discounted_price = None
        logger.info("No discounted seeds available.")
    
    # Render the home page with the random discounted seed and latest seed
    return render(request, 'home/home.html', {
        'random_discounted_seed': random_discounted_seed,
        'discounted_price': discounted_price,
        'latest_seed': latest_seed,
    })
