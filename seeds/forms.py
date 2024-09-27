from django import forms
from .models import Seed

# Category choices for the form dropdown
CATEGORY_CHOICES = [
    ('rose', 'Rose'),
    ('flower', 'Flower'),
    ('tree', 'Tree'),
    ('bush', 'Bush'),
]

class SeedForm(forms.ModelForm):
    # Define the category field explicitly with choices
    category = forms.ChoiceField(choices=CATEGORY_CHOICES, label="Category")

    class Meta:
        model = Seed
        fields = [
            'name', 'scientific_name', 'description', 'planting_months_from',
            'planting_months_to', 'flowering_months_from', 'flowering_months_to',
            'category', 'height_from', 'height_to', 'sun_preference', 'price',
            'discount', 'is_in_stock', 'image'
        ]
        
        # Custom widgets to add Bootstrap classes
        widgets = {
            'description': forms.Textarea(attrs={'rows': 4, 'class': 'form-control'}),
            'planting_months_from': forms.NumberInput(attrs={'min': 1, 'max': 12, 'class': 'form-control'}),
            'planting_months_to': forms.NumberInput(attrs={'min': 1, 'max': 12, 'class': 'form-control'}),
            'flowering_months_from': forms.NumberInput(attrs={'min': 1, 'max': 12, 'class': 'form-control'}),
            'flowering_months_to': forms.NumberInput(attrs={'min': 1, 'max': 12, 'class': 'form-control'}),
            'height_from': forms.NumberInput(attrs={'step': 0.01, 'class': 'form-control'}),
            'height_to': forms.NumberInput(attrs={'step': 0.01, 'class': 'form-control'}),
            'price': forms.NumberInput(attrs={'step': 0.01, 'class': 'form-control'}),
            'discount': forms.NumberInput(attrs={'step': 0.01, 'class': 'form-control'}),
            'image': forms.ClearableFileInput(attrs={'class': 'form-control'}),
        }

        # Labels for better form readability
        labels = {
            'name': 'Seed Name',
            'scientific_name': 'Scientific Name',
            'description': 'Description',
            'planting_months_from': 'Planting Months From',
            'planting_months_to': 'Planting Months To',
            'flowering_months_from': 'Flowering Months From',
            'flowering_months_to': 'Flowering Months To',
            'category': 'Category',
            'height_from': 'Height From (cm)',
            'height_to': 'Height To (cm)',
            'sun_preference': 'Sun Preference',
            'price': 'Price ($)',
            'discount': 'Discount (%)',
            'is_in_stock': 'In Stock?',
            'image': 'Seed Image',
        }

        # Error messages for form validation
        error_messages = {
            'name': {
                'required': 'Please enter the seed name.',
            },
            'price': {
                'required': 'Please enter a valid price.',
                'invalid': 'Please enter a valid number.',
            },
            # Add other field-specific error messages as needed
        }

class SearchForm(forms.Form):
    query = forms.CharField(
        max_length=100,
        required=False,
        widget=forms.TextInput(attrs={'placeholder': 'Search seeds...', 'class': 'form-control'})
    )
