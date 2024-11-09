from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import login as auth_login, logout as auth_logout
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.http import HttpResponse, JsonResponse, HttpResponseRedirect
from django.urls import reverse
from django.conf import settings
from django.core.mail import send_mail
from custom_accounts.models import UserProfile
from django.db.models.signals import post_save
from django.dispatch import receiver
from django.contrib.auth.models import User
from reviews.models import Review, Comment 
from checkout.models import Order
from communications.models import ChatConversation, ChatMessage 
from .forms import ProfileEditForm , CustomUserCreationForm
from django.core.exceptions import ObjectDoesNotExist

import os
# Import logging module
import logging
logger = logging.getLogger(__name__)

@login_required
def edit_profile(request):
    # Retrieve the profile for the logged-in user directly
    profile = request.user.profile

    if request.method == 'POST':
        form = ProfileEditForm(request.POST, request.FILES, instance=profile)
        if form.is_valid():
            form.save()  # Save the updated profile
            messages.success(request, 'Your profile has been updated successfully!')
            return redirect('profile')  # Redirect to the profile page after saving changes
    else:
        form = ProfileEditForm(instance=profile)  # Pre-fill form with current profile data

    return render(request, 'custom_accounts/edit_profile.html', {'form': form})

def register(request):
    if request.method == 'POST':
        form = CustomUserCreationForm(request.POST)
        if form.is_valid():
            user = form.save()  # Save the user instance
            newsletter_preference = form.cleaned_data.get("newsletter", False)
            user.backend = 'allauth.account.auth_backends.AuthenticationBackend'

            # Log the user in after registration
            auth_login(request, user)
            messages.success(request, 'Registration successful.')
            # Send the welcome email if newsletter preference is checked
            # Send the welcome email if newsletter preference is checked
            if newsletter_preference:
                logger.info(f"User {user.username} opted in for the newsletter.")
                send_welcome_email(user)
            else:
                logger.info(f"User {user.username} did not opt in for the newsletter.")

            # Redirect to the home page after logging in
            return redirect('home')
        else:
            messages.error(request, 'Please correct the errors below.')
    else:
        form = CustomUserCreationForm()  # Create an instance of your custom form

    return render(request, 'custom_accounts/register.html', {'form': form})
def welcome_message(request):
    return render(request, 'custom_accounts/welcome_message.html')
    
def login(request):
    if request.method == 'POST':
        form = AuthenticationForm(request, data=request.POST)
        
        # Print form errors if form is invalid
        if not form.is_valid():
            print(f"Form errors: {form.errors}")
            return JsonResponse({'success': False, 'errors': form.errors}, status=400)

        user = form.get_user()
        auth_login(request, user)  # Log the user in

        if not hasattr(user, 'profile'):
            return JsonResponse({'success': False, 'redirect': '/register'})  # Redirect if no profile

        # Return a JSON response indicating success and redirect
        return JsonResponse({'success': True, 'redirect': '/'})
    
    # For GET requests or other request methods, render the login page
    form = AuthenticationForm()
    return render(request, 'custom_accounts/login.html', {'form': form})


def send_welcome_email(user):
    subject = "Welcome to Future Flower Shop!"
    message = f"Hi {user.username},\n\nThank you for registering at Future Flower Shop! We’re excited to have you with us."
    email_from = settings.DEFAULT_FROM_EMAIL
    recipient_list = [user.email]
    
    try:
        send_mail(subject, message, email_from, recipient_list, fail_silently=False)
        logger.info(f"Welcome email sent successfully to {user.email}.")
    except Exception as e:
        pass


def send_newsletter(request):
    if request.method == 'POST':
        subject = request.POST.get('subject')
        message = request.POST.get('message')

        # Get all users who receive newsletters
        users = UserProfile.objects.filter(receives_newsletter=True)
     
        # Send email to each user
        for user_profile in users:
            try:
                # Check if the user_profile has an associated user
                try:
                    if user_profile.user:  # This will now safely check the 'user' field
                        logger.info(f"Attempting to send email to {user_profile.user.email}")
                        send_mail(
                            subject,
                            message,
                            os.environ.get('EMAIL_HOST_USER'),  # Ensure you're using the correct email
                            [user_profile.user.email],
                            fail_silently=False,
                        )
                        logger.info(f"Newsletter sent successfully to {user_profile.user.email}.")
                        messages.success(request, f"Newsletter sent to {user_profile.user.email}.")
                    else:
                        logger.warning(f"User profile {user_profile.id} has no associated user.")
                        messages.warning(request, f"User profile {user_profile.id} has no associated user. Skipping.")
                except UserProfile.user.RelatedObjectDoesNotExist:
                    # This is the exception raised when the related user is missing
                    logger.warning(f"UserProfile with ID {user_profile.id} has no related User object.")
                    messages.warning(request, f"User profile {user_profile.id} has no associated user. Skipping.")
            except Exception as e:
                # Handle and log any exceptions that occur during the email sending
                logger.error(f"Failed to send email to {user_profile.user.email if user_profile.user else 'Unknown User'}: {str(e)}")
                messages.error(request, f"Failed to send email to {user_profile.user.email if user_profile.user else 'Unknown User'}: {str(e)}")

        return redirect('admin_dashboard')

    return render(request, 'admin_dashboard')

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
    request.session.flush()
    auth_logout(request)
    return redirect('home')


@login_required
def profile(request):
    try:
        profile = UserProfile.objects.get(user=request.user)
    except UserProfile.DoesNotExist:
        profile = None  # Handle case where the profile doesn't exist

    # Fetch orders associated with the profile
    if profile:
        orders = Order.objects.filter(user_profile=profile)
        if not orders.exists():
            print(f"No orders found for user {request.user.username}.")
    else:
        orders = []

    # Prepare the profile image URL (ensure HTTPS)
    if profile and profile.profile_image:
        profile_image_url = profile.profile_image.url
        # Ensure profile image URL uses HTTPS (if applicable)
        if profile_image_url.startswith("http://"):
            profile_image_url = profile_image_url.replace("http://", "https://")
    else:
        # If no image is set, you can provide a default image URL
        profile_image_url = f'{settings.STATIC_URL}images/user-icon.png'

    # Pass the profile image URL and other data to the template
    return render(request, 'custom_accounts/profile.html', {
        'orders': orders,
        'profile': profile,  # Pass the profile to the template
        'profile_image_url': profile_image_url  # Pass the image URL
    })


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