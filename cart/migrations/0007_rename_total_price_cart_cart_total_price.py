# Generated by Django 5.1 on 2024-09-16 15:16

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('cart', '0006_cart_total_price'),
    ]

    operations = [
        migrations.RenameField(
            model_name='cart',
            old_name='total_price',
            new_name='cart_total_price',
        ),
    ]