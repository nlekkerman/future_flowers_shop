# Generated by Django 5.1 on 2024-10-25 14:27

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('custom_accounts', '0005_userprofile_receives_newsletter'),
    ]

    operations = [
        migrations.AddField(
            model_name='userprofile',
            name='email',
            field=models.EmailField(blank=True, max_length=254, null=True),
        ),
    ]