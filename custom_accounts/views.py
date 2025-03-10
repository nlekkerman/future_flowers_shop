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
from seeds.models import Seed
from checkout.models import Order
from communications.models import Conversation, ChatMessage 
from .forms import ProfileEditForm , CustomUserCreationForm
from django.core.exceptions import ObjectDoesNotExist
from django.views.decorators.csrf import csrf_protect, csrf_exempt
import os
# Import logging module
import logging
logger = logging.getLogger(__name__)

@login_required
def edit_profile(request):
    """
    Allows authenticated users to edit their profile details such as their profile image and name.

    This view retrieves the current user's profile information and initializes a form with the
    existing data. If a POST request is received, it validates the form and updates the user's
    profile with the new information. On successful update, the user is redirected to their profile
    page and a success message is displayed.

    Parameters:
        request (HttpRequest): The HTTP request object containing metadata about the request.

    Returns:
        HttpResponse: Renders 'custom_accounts/edit_profile.html' with the form if GET request or
                      redirects to 'profile' page after successful form submission.
    """
    profile = request.user.profile

    if request.method == 'POST':
        form = ProfileEditForm(request.POST, request.FILES, instance=profile)
        if form.is_valid():
            form.save()  # Save the updated profile
            messages.success(request, 'Your profile has been updated successfully!')
            return redirect('custom_accounts:profile')  # Redirect to the profile page after saving changes
    else:
        form = ProfileEditForm(instance=profile)  # Pre-fill form with current profile data

    return render(request, 'custom_accounts/edit_profile.html', {'form': form})


def register(request):
    """
    Handles user registration with an option for newsletter subscription.

    If the request method is POST, the form data is validated. On successful validation, a new user
    instance is created, logged in, and optionally subscribed to the newsletter. A welcome email is
    sent if the user opts in for the newsletter. If the form submission is invalid, error messages
    are displayed.

    Parameters:
        request (HttpRequest): The HTTP request object containing user-submitted data.

    Returns:
        HttpResponse: Renders 'custom_accounts/register.html' with the form if GET request or
                      redirects to 'home' page after successful registration.
    """
    if request.method == 'POST':
        form = CustomUserCreationForm(request.POST)
        if form.is_valid():
            user = form.save() 
            newsletter_preference = form.cleaned_data.get("newsletter", False)
            user.backend = 'allauth.account.auth_backends.AuthenticationBackend'

            
            auth_login(request, user)
            

            if newsletter_preference:
                logger.info(f"User {user.username} opted in for the newsletter.")
                send_welcome_email(user)
            else:
                logger.info(f"User {user.username} did not opt in for the newsletter.")

            
            return redirect('custom_accounts:welcome_message')
        else:
            messages.error(request, 'Please correct the errors below.')
    else:
        form = CustomUserCreationForm()

    return render(request, 'custom_accounts/register.html', {'form': form})

def login(request):
    """
    Authenticates and logs in users, handling both valid and invalid form submissions.
    """
    if request.method == 'POST':
        form = AuthenticationForm(request, data=request.POST)
        if form.is_valid():
            user = form.get_user()
            auth_login(request, user)

            # Check if the user has a profile (if you have a profile model)
            if not hasattr(user, 'profile'):
                return JsonResponse({'success': False, 'redirect': '/register'})

            # Return a JSON response indicating success
            return JsonResponse({'success': True, 'redirect': '/'} )
        else:
             # If the form is invalid, filter out the __all__ errors and return others
            errors = form.errors.as_json()
            general_error = form.non_field_errors()  # Get non-field errors (if any)

            # Return the JSON response with errors, without including '__all__' key
            return JsonResponse({
                'success': False,
                'general_error': general_error[0] if general_error else None,  # Only send the first general error
                'errors': errors
            }, status=400)

    # For GET requests, render the login page with an empty form
    form = AuthenticationForm()
    return render(request, 'custom_accounts/login.html', {'form': form})    


def send_welcome_email(user):
    """
    Sends a personalized welcome email to new users after registration.

    Constructs the welcome email with a subject and message, including the user's username.
    Uses the Django `send_mail` utility to send the email to the user's registered email address.
    Logs successful email sending or logs any encountered errors.

    Parameters:
        user (User): The registered user who should receive the welcome email.

    Returns:
        None: No direct response as this function is called within other views, but logs results.
    """
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
    """
    Distributes a newsletter to users who have opted into receiving emails.

    Upon receiving a POST request, the newsletter's subject and message are extracted from the
    request data. The view then filters for users subscribed to newsletters and sends the message to
    each subscriber using the Django `send_mail` function. Logs are created for each email
    successfully sent or any failure.

    Parameters:
        request (HttpRequest): Contains the subject and message data for the newsletter.

    Returns:
        HttpResponseRedirect: Redirects back to 'admin_dashboard' after sending the newsletter.
    """
    if request.method == 'POST':
        subject = request.POST.get('subject')
        message = request.POST.get('message')

        # Get all users who receive newsletters
        users = UserProfile.objects.filter(receives_newsletter=True)
     
        # Send email to each user
        for user_profile in users:
            try:
                
                try:
                    if user_profile.user:
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

        return redirect('custom_accounts:admin_dashboard')

    return render(request, 'custom_accounts:admin_dashboard')

@receiver(post_save, sender=User)
def create_or_update_user_profile(sender, instance, created, **kwargs):
    """
    Automatically creates or updates a user profile when a user account is created or modified.

    This signal handler triggers on user creation or update. If the user is newly created and no
    associated profile exists, it creates one. If the user is updated, it ensures an associated
    profile exists and saves any updates. This helps to maintain a synchronized User and UserProfile
    relationship.

    Parameters:
        sender (Model): The model class (User) that triggered the signal.
        instance (User): The specific instance of the model being saved.
        created (bool): Indicates whether the user was newly created or updated.

    Returns:
        None: The function is a signal handler and does not return a response.
    """
    if created:
        if not UserProfile.objects.filter(user=instance).exists():
            UserProfile.objects.create(user=instance)
    else:
        # Update the existing profile if needed
        profile, created = UserProfile.objects.get_or_create(user=instance)
        profile.save()


def logout(request):
    """
    Logs out the current user and clears the session data.

    This view handles the logout process by clearing the session data using `flush` and then
    calling `auth_logout` to log out the user from the Django authentication system. After
    logging out, the user is redirected to the home page.

    Parameters:
        request (HttpRequest): The HTTP request object.

    Returns:
        HttpResponseRedirect: Redirects the user to the 'home' page after logout.
    """
    request.session.flush()
    auth_logout(request)
    return redirect('home:home')


@login_required
def profile(request):
    """
    Displays the user's profile along with their associated orders.

    This view fetches the current user's profile and their associated orders. If no profile
    exists, a default profile image is provided, and no orders are shown. It also ensures that
    the profile image URL is secure (HTTPS) if necessary.

    Parameters:
        request (HttpRequest): The HTTP request object containing the logged-in user.

    Returns:
        HttpResponse: Renders the 'custom_accounts/profile.html' template with profile, orders,
                      and profile image URL context.
    """
    try:
        profile = UserProfile.objects.get(user=request.user)
    except UserProfile.DoesNotExist:
        profile = None

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
        'profile': profile, 
        'profile_image_url': profile_image_url 
    })


@login_required
def admin_dashboard(request):
    """
    Displays pending reviews, comments, and chat conversations for administrative review.

    The view fetches all reviews and comments with a 'pending' status and lists all chat
    conversations. This allows administrators to review and moderate content before it is displayed
    publicly. Each item can be approved, rejected, or deleted as per the available management views.

    Parameters:
        request (HttpRequest): The HTTP request, used to identify the user and request type.

    Returns:
        HttpResponse: Renders 'custom_accounts/admin_dashboard.html' with pending reviews, comments,
                      and conversations for administrative actions.
    """
   
    pending_reviews = Review.objects.filter(status='pending')
    pending_comments = Comment.objects.filter(status='pending')
    seeds = Seed.objects.all()
    # Fetch all chat conversations
    conversations = Conversation.objects.all() 

    context = {
        'pending_reviews': pending_reviews,
        'pending_comments': pending_comments,
        'conversations': conversations,
        'seeds': seeds,
    }
    return render(request, 'custom_accounts/admin_dashboard.html', context)

def approve_review(request, id):
    """
    Approves a review by setting its status to 'approved'.

    This view retrieves the review by ID, sets its status to 'approved', saves the changes, and
    displays a success message. The admin is then redirected back to the admin dashboard.

    Parameters:
        request (HttpRequest): The HTTP request object.
        id (int): The ID of the review to approve.

    Returns:
        HttpResponseRedirect: Redirects to the 'admin_dashboard' after approving the review.
    """
    review = get_object_or_404(Review, id=id)
    review.status = 'approved'
    review.is_approved = True
    review.save()
    messages.success(request, "Review has been approved.")
    return redirect('custom_accounts:admin_dashboard')

def reject_review(request, id):
    """
    Rejects a review by setting its status to 'rejected'.

    This view retrieves the review by ID, sets its status to 'rejected', saves the changes, and
    displays a success message. The admin is then redirected back to the admin dashboard.

    Parameters:
        request (HttpRequest): The HTTP request object.
        id (int): The ID of the review to reject.

    Returns:
        HttpResponseRedirect: Redirects to the 'admin_dashboard' after rejecting the review.
    """
    review = get_object_or_404(Review, id=id)
    review.status = 'rejected'
    review.is_approved = False
    review.save()
    messages.success(request, "Review has been rejected.")
    return redirect('custom_accounts:admin_dashboard')

def delete_review(request, id):
    """
    Deletes a review from the database.

    This view retrieves the review by ID and deletes it. After deletion, a success message is
    displayed, and the admin is redirected to the admin dashboard.

    Parameters:
        request (HttpRequest): The HTTP request object.
        id (int): The ID of the review to delete.

    Returns:
        HttpResponseRedirect: Redirects to the 'admin_dashboard' after deleting the review.
    """
    review = get_object_or_404(Review, id=id)
    review.delete()
    messages.success(request, "Review has been deleted.")
    return redirect('custom_accounts:admin_dashboard')

def approve_comment(request, id):
    """
    Approves a comment by setting its status to 'approved'.

    This view retrieves the comment by ID, sets its status to 'approved', saves the changes,
    and displays a success message. The admin is then redirected back to the admin dashboard.

    Parameters:
        request (HttpRequest): The HTTP request object.
        id (int): The ID of the comment to approve.

    Returns:
        HttpResponseRedirect: Redirects to the 'admin_dashboard' after approving the comment.
    """
    comment = get_object_or_404(Comment, id=id)
    comment.status = 'approved'
    comment.save()
    messages.success(request, "Comment has been approved.")
    return redirect('custom_accounts:admin_dashboard')

def reject_comment(request, id):
    """
    Rejects a comment by setting its status to 'rejected'.

    This view retrieves the comment by ID, sets its status to 'rejected', saves the changes,
    and displays a success message. The admin is then redirected back to the admin dashboard.

    Parameters:
        request (HttpRequest): The HTTP request object.
        id (int): The ID of the comment to reject.

    Returns:
        HttpResponseRedirect: Redirects to the 'admin_dashboard' after rejecting the comment.
    """
    comment = get_object_or_404(Comment, id=id)
    comment.status = 'rejected'
    comment.save()
    messages.success(request, "Comment has been rejected.")
    return redirect('custom_accounts:admin_dashboard')

def delete_comment(request, id):
    """
    Deletes a comment from the database.

    This view retrieves the comment by ID and deletes it. After deletion, a success message is
    displayed, and the admin is redirected to the admin dashboard.

    Parameters:
        request (HttpRequest): The HTTP request object.
        id (int): The ID of the comment to delete.

    Returns:
        HttpResponseRedirect: Redirects to the 'admin_dashboard' after deleting the comment.
    """
    comment = get_object_or_404(Comment, id=id)
    comment.delete()
    messages.success(request, "Comment has been deleted.")
    return redirect('custom_accounts:admin_dashboard')



    """
    Displays the details of a chat conversation, including all related messages.

    This view fetches the chat conversation by ID and retrieves all messages associated with it.
    The conversation and its messages are then passed to the template for display.

    Parameters:
        request (HttpRequest): The HTTP request object.
        conversation_id (int): The ID of the conversation to display.

    Returns:
        HttpResponse: Renders 'communications/conversation_detail.html' with conversation
                      and messages context.
    """
    conversation = get_object_or_404(ChatConversation, id=conversation_id)
    chat_messages = conversation.messages.all()  # Assuming you have a related name or reverse relationship

    return render(request, 'communications/conversation_detail.html', {
        'conversation': conversation,
        'chat_messages': chat_messages
    })
    
def custom_404(request, exception):
    """
    Custom 404 error handler.

    This function handles requests that result in a 'Page Not Found' (404) error.
    It renders a custom 404 error page (`404.html`) located in the `custom_accounts` folder
    and returns a response with a 404 status code.
    
    Args:
    - request: The HTTP request object that triggered the 404 error.
    - exception: The exception raised when the page is not found (not used here, but included for compatibility).
    
    Returns:
    - A rendered 404 error page with a 404 HTTP status.
    """
    return render(request, 'custom_accounts/404.html', {}, status=404)

def welcome_message(request):
    """
    Displays a welcome message to the user after they successfully register.

    Parameters:
        request (HttpRequest): The HTTP request object.

    Returns:
        HttpResponse: Renders 'custom_accounts/welcome_message.html' with a welcome message.
    """
    return render(request, 'custom_accounts/welcome_message.html')

