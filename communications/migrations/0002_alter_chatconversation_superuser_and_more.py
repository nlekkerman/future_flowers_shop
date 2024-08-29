# Generated by Django 5.1 on 2024-08-29 11:04

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('communications', '0001_initial'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.AlterField(
            model_name='chatconversation',
            name='superuser',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='communications_superuser_conversations', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AlterField(
            model_name='chatconversation',
            name='user',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='communications_user_conversations', to=settings.AUTH_USER_MODEL),
        ),
        migrations.CreateModel(
            name='Message',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('content', models.TextField()),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('conversation', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='communications_messages', to='communications.chatconversation')),
                ('sender', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='communications_sent_messages', to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
