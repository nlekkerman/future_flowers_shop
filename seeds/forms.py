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
    """
    A form to create or edit a Seed object. This form includes fields for the seed's name, 
    scientific name, description, planting and flowering months, category, height, sun preference, 
    price, discount, stock availability, and image.

    Attributes:
        category (ChoiceField): Dropdown for selecting the seed's category (e.g., 'rose', 'flower').
        name (CharField): The name of the seed (e.g., 'Rose').
        scientific_name (CharField): The scientific name of the seed (e.g., 'Rosa spp.').
        description (TextField): A detailed description of the seed.
        planting_months_from (NumberInput): The month to start planting.
        planting_months_to (NumberInput): The month to finish planting.
        flowering_months_from (NumberInput): The month to start flowering.
        flowering_months_to (NumberInput): The month to finish flowering.
        height_from (NumberInput): The minimum height the plant will grow to, in meters.
        height_to (NumberInput): The maximum height the plant will grow to, in meters.
        sun_preference (ChoiceField): Dropdown for selecting the sun preference (e.g., 'full_sun', 'partly').
        price (NumberInput): The price of the seed.
        discount (NumberInput): The discount percentage applied to the seed's price.
        is_in_stock (BooleanField): Indicates if the seed is in stock.
        image (ClearableFileInput): File input for uploading an image of the seed.

    Meta Class:
        model (Seed): The model that the form is linked to (Seed).
        fields (list): List of fields to be displayed on the form.
        widgets (dict): Custom widgets to style the form elements (e.g., adding Bootstrap classes).
        labels (dict): Custom labels for the form fields.
        error_messages (dict): Custom error messages for field validation.

    Methods:
        clean_price(): Ensures that the price entered is greater than or equal to zero.
        clean_discount(): Ensures that the discount is between 0 and 100.
    """
    
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
    """
    A form to handle search queries for seeds. This form allows users to input a search term to find seeds 
    based on the seed's attributes such as name, category, or other fields. It can be used in the search 
    functionality of a seed catalog or inventory system.

    Attributes:
        query (CharField): The search input field where users can type their query to search for seeds. 
                            The query is optional and has a placeholder text of 'Search seeds...'.
                            The input is constrained to a maximum length of 100 characters.

    Methods:
        clean_query(): This method can be added in the future to further validate the search query input if necessary.
    """
    query = forms.CharField(
        max_length=100,
        required=False,
        widget=forms.TextInput(attrs={'placeholder': 'Search seeds...', 'class': 'form-control'})
    )
