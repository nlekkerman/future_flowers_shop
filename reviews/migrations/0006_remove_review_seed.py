# Generated by Django 5.1 on 2024-09-11 09:23

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('reviews', '0005_comment_deleted_comment_last_modified_review_deleted_and_more'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='review',
            name='seed',
        ),
    ]
