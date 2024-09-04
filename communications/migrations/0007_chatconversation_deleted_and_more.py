# Generated by Django 5.1 on 2024-08-31 21:52

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('communications', '0006_rename_message_chatmessage_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='chatconversation',
            name='deleted',
            field=models.BooleanField(default=False),
        ),
        migrations.AddField(
            model_name='chatconversation',
            name='last_modified',
            field=models.DateTimeField(auto_now=True),
        ),
        migrations.AddField(
            model_name='chatmessage',
            name='deleted',
            field=models.BooleanField(default=False),
        ),
        migrations.AddField(
            model_name='chatmessage',
            name='last_modified',
            field=models.DateTimeField(auto_now=True),
        ),
    ]