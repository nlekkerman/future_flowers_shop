from .models import Seed

def calculate_discounted_price(seed):
    """Calculate the price after discount for a given seed."""
    if not isinstance(seed, Seed):
        raise ValueError("Expected an instance of Seed.")
    return seed.price - (seed.price * (seed.discount / 100))

def is_seed_in_stock(seed):
    """Check if the given seed is in stock."""
    if not isinstance(seed, Seed):
        raise ValueError("Expected an instance of Seed.")
    return seed.in_stock > 0
