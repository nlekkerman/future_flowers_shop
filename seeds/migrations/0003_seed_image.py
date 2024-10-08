# Generated by Django 5.1 on 2024-08-14 10:37

import cloudinary.models
from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('seeds', '0002_seed_height_from_seed_height_to'),
    ]

    operations = [
        migrations.AddField(
            model_name='seed',
            name='image',
            field=cloudinary.models.CloudinaryField(blank=True, help_text='Upload an image of the seed', max_length=255, null=True, verbose_name='image'),
        ),
    ]
