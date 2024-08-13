from .models import Seed


def seed_data(request):
    all_seeds = Seed.objects.all()
    return {
        'all_seeds': all_seeds,
    }
