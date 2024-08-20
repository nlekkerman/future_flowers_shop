from django.shortcuts import render, redirect
from django.contrib.auth import login as auth_login, logout as auth_logout
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.http import HttpResponse
from django.conf import settings

def welcome_message(request):
    # Ensure that the user object is available
    return render(request, 'custom_accounts/welcome_message.html')

    
def register(request):
    if request.method == 'POST':
        form = UserCreationForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, 'Registration successful.')
            return redirect('welcome_message')
        else:
            messages.error(request, 'Please correct the errors below.')
    else:
        form = UserCreationForm()

    return render(request, 'custom_accounts/register.html', {'form': form})

def login(request):
    if request.method == 'POST':
        form = AuthenticationForm(request, data=request.POST)
        if form.is_valid():
            user = form.get_user()
            auth_login(request, user)
            return redirect('/')
    else:
        form = AuthenticationForm()
    return render(request, 'custom_accounts/login.html', {'form': form})

def logout(request):
    auth_logout(request)
    return redirect('account_login')

@login_required
def profile(request):
    return render(request, 'custom_accounts/profile.html')
def debug_view(request):
    # Generate the URLs to print
    redirect_uri = 'https://8000-nlekkerman-futureflower-v9397r1bhgn.ws.codeinstitute-ide.net/accounts/google/login/callback/'
    client_id = settings.SOCIALACCOUNT_PROVIDERS['google']['APP']['client_id']
    client_secret = settings.SOCIALACCOUNT_PROVIDERS['google']['APP']['secret']

    # Prepare the response with URLs and credentials
    response = (
        f"Redirect URI: {redirect_uri}\n"
        f"Client ID: {client_id}\n"
        f"Client Secret: {client_secret}"
    )
    return HttpResponse(response, content_type="text/plain")