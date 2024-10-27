
from django import forms
from .models import UserProfile
from django.contrib.auth.models import User
from django.contrib.auth.forms import UserCreationForm
import logging

# Set up logging
logger = logging.getLogger(__name__)


class ProfileEditForm(forms.ModelForm):
    class Meta:
        model = UserProfile
        fields = ['address', 'phone_number', 'profile_image', 'about_self']  # Include about_self
        widgets = {
            'address': forms.TextInput(attrs={'class': 'form-control'}),
            'phone_number': forms.TextInput(attrs={'class': 'form-control'}),
            'about_self': forms.Textarea(attrs={'class': 'form-control', 'rows': 3}),  
        }


class CustomUserCreationForm(UserCreationForm):
    email = forms.EmailField(required=True, help_text="Required. Enter a valid email address.")
    newsletter = forms.BooleanField(required=False, initial=False, label="Receive Newsletter")

    class Meta:
        model = User
        fields = ("username", "email", "password1", "password2")

    def save(self, commit=True):
        user = super().save(commit=False)
        user.email = self.cleaned_data["email"]

        # Log the value of the newsletter checkbox
        newsletter_opt_in = self.cleaned_data.get("newsletter", False)
        logger.info(f"Newsletter checkbox value: {newsletter_opt_in}")

        if commit:
            user.save()

            # Update or create the UserProfile with the newsletter preference
            profile, created = UserProfile.objects.get_or_create(user=user)
            profile.receives_newsletter = newsletter_opt_in
            profile.email = self.cleaned_data["email"]
            profile.save()  # Save the updated profile

        return user


