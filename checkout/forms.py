from django import forms
from .models import Order

class OrderForm(forms.ModelForm):
    class Meta:
        model = Order
        fields = (
            'full_name', 'email', 'phone_number',
            'street_address1', 'street_address2',
            'town_or_city', 'postcode', 'country',
            'county','user_profile',
        )
        widgets = {
            'country': forms.Select(attrs={'class': 'stripe-style-input form-control'}),
            'full_name': forms.TextInput(attrs={'class': 'stripe-style-input form-control'}),
            'email': forms.EmailInput(attrs={'class': 'stripe-style-input form-control'}),
            'phone_number': forms.TextInput(attrs={'class': 'stripe-style-input form-control'}),
            'street_address1': forms.TextInput(attrs={'class': 'stripe-style-input form-control'}),
            'street_address2': forms.TextInput(attrs={'class': 'stripe-style-input form-control'}),
            'town_or_city': forms.TextInput(attrs={'class': 'stripe-style-input form-control'}),
            'postcode': forms.TextInput(attrs={'class': 'stripe-style-input form-control'}),
            'county': forms.TextInput(attrs={'class': 'stripe-style-input form-control'}),
        }

    def __init__(self, *args, **kwargs):
        """
        Add placeholders and classes, remove auto-generated
        labels, and set autofocus on the first field.
        """
        super().__init__(*args, **kwargs)
        placeholders = {
            'full_name': 'Full Name',
            'email': 'Email Address',
            'phone_number': 'Phone Number',
            'postcode': 'Postal Code',
            'town_or_city': 'Town or City',
            'street_address1': 'Street Address 1',
            'street_address2': 'Street Address 2',
            'county': 'County, State or Locality',
        }

        self.fields['full_name'].widget.attrs['autofocus'] = True

        for field in self.fields:
            placeholder = placeholders.get(field, '')
            if self.fields[field].required:
                placeholder += ' *'
            self.fields[field].widget.attrs['placeholder'] = placeholder
            self.fields[field].widget.attrs['class'] = 'stripe-style-input'
            self.fields[field].label = False
