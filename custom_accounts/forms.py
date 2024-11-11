
from django import forms
from .models import UserProfile
from django.contrib.auth.models import User
from django.contrib.auth.forms import UserCreationForm
import logging

# Set up logging
logger = logging.getLogger(__name__)


class ProfileEditForm(forms.ModelForm):
    """
    Form for editing the UserProfile details.

    Meta:
        model (UserProfile): Links the form to the UserProfile model.
        fields (list): Specifies which fields to include in the form, here: 'address', 'phone_number', 'profile_image', and 'about_self'.
        widgets (dict): Maps fields to custom widgets to enhance the user interface.
            - 'address': Uses a TextInput widget with 'form-control' class for Bootstrap styling.
            - 'phone_number': Uses a TextInput widget for user input with 'form-control' class.
            - 'about_self': Uses a Textarea widget with 'form-control' class, setting rows to 3 for multi-line input.
    """
    class Meta:
        model = UserProfile
        fields = ['address', 'phone_number', 'profile_image', 'about_self']
        widgets = {
            'address': forms.TextInput(attrs={'class': 'form-control'}),
            'phone_number': forms.TextInput(attrs={'class': 'form-control'}),
            'about_self': forms.Textarea(attrs={'class': 'form-control', 'rows': 3}),  
        }


class CustomUserCreationForm(UserCreationForm):
    """
    Custom user creation form that extends Django's UserCreationForm to include additional fields.

    Fields:
        email (EmailField): Required field with validation for a valid email format, includes help text.
        newsletter (BooleanField): Optional checkbox for subscribing to the newsletter; defaults to False.

    Meta:
        model (User): Associates the form with Django's User model.
        fields (tuple): Specifies fields to display in the form: 'username', 'email', 'password1', 'password2'.

    Methods:
        save(commit=True):
            Saves the User instance and updates the UserProfile with the newsletter preference if selected.

            Parameters:
                commit (bool): Determines if the user instance is saved to the database immediately (default is True).
            
            Returns:
                User: The created or updated User instance.
    """
    email = forms.EmailField(required=True, help_text="Required. Enter a valid email address.")
    newsletter = forms.BooleanField(required=False, initial=False, label="Receive Newsletter")

    class Meta:
        model = User
        fields = ("username", "email", "password1", "password2")

    def save(self, commit=True):
        """
        Custom save method to handle additional fields and update UserProfile.

        Saves the user's email address to the User instance and sets the newsletter preference in UserProfile.
        Logs the newsletter subscription status, then either saves the user immediately or defers to the caller.

        Parameters:
            commit (bool): If True, saves the User instance and UserProfile to the database; otherwise, the caller must save them.

        Returns:
            user (User): The User instance that was created or updated.
        """
        user = super().save(commit=False)
        user.email = self.cleaned_data["email"]


        newsletter_opt_in = self.cleaned_data.get("newsletter", False)
        logger.info(f"Newsletter checkbox value: {newsletter_opt_in}")

        if commit:
            user.save()
            profile, created = UserProfile.objects.get_or_create(user=user)
            profile.receives_newsletter = newsletter_opt_in
            profile.email = self.cleaned_data["email"]
            profile.save() 

        return user


