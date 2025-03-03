# Generated by Django 5.1.4 on 2025-02-20 09:01

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('reviews', '0006_remove_review_seed'),
        ('seeds', '0007_seed_in_stock_number'),
    ]

    operations = [
        migrations.AddField(
            model_name='review',
            name='seed',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='reviews', to='seeds.seed'),
        ),
    ]
