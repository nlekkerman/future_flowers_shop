from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import login as auth_login, logout as auth_logout
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.http import HttpResponse
from django.urls import reverse
from django.conf import settings
from custom_accounts.models import UserProfile
from django.db.models.signals import post_save
from django.dispatch import receiver
from django.contrib.auth.models import User

def welcome_message(request):
    return render(request, 'custom_accounts/welcome_message.html')

def login(request):
    if request.method == 'POST':
        form = AuthenticationForm(request, data=request.POST)
        if form.is_valid():
            user = form.get_user()
            auth_login(request, user)

            # Ensure the user has a profile
            if not hasattr(user, 'profile'):
                return redirect('register')  # Redirect to the registration page if no profile exists

            return redirect('home')  # Redirect to profile or any other page
    else:
        form = AuthenticationForm()
    return render(request, 'custom_accounts/login.html', {'form': form})

def register(request):
    if request.method == 'POST':
        form = UserCreationForm(request.POST)
        if form.is_valid():
            user = form.save()
            # Manually set the backend attribute
            user.backend = 'django.contrib.auth.backends.ModelBackend'
            auth_login(request, user)
            messages.success(request, 'Registration successful.')

            # Create a user profile upon registration
            if not UserProfile.objects.filter(user=user).exists():
                UserProfile.objects.create(user=user)
            
            # Redirect to the home page after logging in
            return redirect(reverse('home'))  # Replace 'home' with your home page URL name
        else:
            messages.error(request, 'Please correct the errors below.')
    else:
        form = UserCreationForm()

    return render(request, 'custom_accounts/register.html', {'form': form})


@receiver(post_save, sender=User)
def create_or_update_user_profile(sender, instance, created, **kwargs):
    if created:
        if not UserProfile.objects.filter(user=instance).exists():
            UserProfile.objects.create(user=instance)
    else:
        # Update the existing profile if needed
        profile, created = UserProfile.objects.get_or_create(user=instance)
        profile.save()

def logout(request):
    auth_logout(request)
    return redirect('account_login')

@login_required
def profile(request):
    return render(request, 'custom_accounts/profile.html')

def debug_view(request):
    redirect_uri = 'https://8000-nlekkerman-futureflower-v9397r1bhgn.ws.codeinstitute-ide.net/accounts/google/login/callback/'
    client_id = settings.SOCIALACCOUNT_PROVIDERS['google']['APP']['client_id']
    client_secret = settings.SOCIALACCOUNT_PROVIDERS['google']['APP']['secret']

    response = (
        f"Redirect URI: {redirect_uri}\n"
        f"Client ID: {client_id}\n"
        f"Client Secret: {client_secret}"
    )
    return HttpResponse(response, content_type="text/plain")
