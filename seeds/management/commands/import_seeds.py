import json
import os
from django.core.management.base import BaseCommand
from django.utils import timezone
from seeds.models import Seed

class Command(BaseCommand):
    help = 'Import seeds from a JSON file'

    def add_arguments(self, parser):
        parser.add_argument('json_file', type=str, help='Path to the JSON file containing seeds data')

    def handle(self, *args, **options):
        json_file = options['json_file']

        if not os.path.exists(json_file):
            self.stderr.write(f"File not found: {json_file}")
            return
        
        with open(json_file, 'r') as f:
            data = json.load(f)
        
        for item in data:
            try:
                created_at = item['created_at']
                if isinstance(created_at, str):
                    created_at = timezone.make_aware(timezone.datetime.fromisoformat(created_at))

                seed, created = Seed.objects.update_or_create(
                    name=item['name'],
                    defaults={
                        'scientific_name': item['scientific_name'],
                        'description': item['description'],
                        'planting_months_from': item['planting_months_from'],
                        'planting_months_to': item['planting_months_to'],
                        'flowering_months_from': item['flowering_months_from'],
                        'flowering_months_to': item['flowering_months_to'],
                        'category': item['category'],
                        'height_from': item['height_from'],
                        'height_to': item['height_to'],
                        'sun_preference': item['sun_preference'],
                        'price': item['price'],
                        'discount': item['discount'],
                        'in_stock': item['in_stock'],
                        'created_at': created_at,
                        'image': item.get('image', None)
                    }
                )
                if created:
                    self.stdout.write(self.style.SUCCESS(f"Successfully created seed: {item['name']}"))
                else:
                    self.stdout.write(self.style.SUCCESS(f"Successfully updated seed: {item['name']}"))
            except KeyError as e:
                self.stderr.write(f"Missing key in data: {e}")
            except Exception as e:
                self.stderr.write(f"Error processing data: {e}")
