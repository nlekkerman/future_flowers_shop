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
from reviews.models import Review, Comment 
from communications.models import ChatConversation, ChatMessage 

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





@login_required
def admin_dashboard(request):
    # Fetch pending reviews and comments
    pending_reviews = Review.objects.filter(status='pending')
    pending_comments = Comment.objects.filter(status='pending')
    
    # Fetch all chat conversations
    conversations = ChatConversation.objects.all()  # Adjust filtering if needed

    context = {
        'pending_reviews': pending_reviews,
        'pending_comments': pending_comments,
        'conversations': conversations,  # Add this line
    }
    return render(request, 'custom_accounts/admin_dashboard.html', context)

def approve_review(request, id):
    review = get_object_or_404(Review, id=id)
    review.status = 'approved'
    review.is_approved = True
    review.save()
    messages.success(request, "Review has been approved.")
    return redirect('admin_dashboard')

def reject_review(request, id):
    review = get_object_or_404(Review, id=id)
    review.status = 'rejected'
    review.is_approved = False
    review.save()
    messages.success(request, "Review has been rejected.")
    return redirect('admin_dashboard')

def delete_review(request, id):
    review = get_object_or_404(Review, id=id)
    review.delete()
    messages.success(request, "Review has been deleted.")
    return redirect('admin_dashboard')

def approve_comment(request, id):
    comment = get_object_or_404(Comment, id=id)
    comment.status = 'approved'
    comment.save()
    messages.success(request, "Comment has been approved.")
    return redirect('admin_dashboard')

def reject_comment(request, id):
    comment = get_object_or_404(Comment, id=id)
    comment.status = 'rejected'
    comment.save()
    messages.success(request, "Comment has been rejected.")
    return redirect('admin_dashboard')

def delete_comment(request, id):
    comment = get_object_or_404(Comment, id=id)
    comment.delete()
    messages.success(request, "Comment has been deleted.")
    return redirect('admin_dashboard')


def conversation_detail_view(request, conversation_id):
    conversation = get_object_or_404(ChatConversation, id=conversation_id)
    chat_messages = conversation.messages.all()  # Assuming you have a related name or reverse relationship

    return render(request, 'communications/conversation_detail.html', {
        'conversation': conversation,
        'chat_messages': chat_messages
    })