
from django import forms
from .models import UserProfile

class ProfileEditForm(forms.ModelForm):
    class Meta:
        model = UserProfile
        fields = ['address', 'phone_number', 'profile_image', 'about_self']  # Include about_self
        widgets = {
            'address': forms.TextInput(attrs={'class': 'form-control'}),
            'phone_number': forms.TextInput(attrs={'class': 'form-control'}),
            'about_self': forms.Textarea(attrs={'class': 'form-control', 'rows': 3}),  
        }
