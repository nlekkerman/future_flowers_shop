from django.db import models
from django.db.models import Sum
from django.conf import settings
from django_countries.fields import CountryField
from seeds.models import Seed
from custom_accounts.models import UserProfile 
import uuid

class Order(models.Model):
    """
    Represents an order placed by a customer, including personal details, 
    shipping information, and order totals. This model tracks the order's 
    lifecycle, including order number, customer info, order items, delivery costs, 
    and the final total cost (including any discounts or shipping fees).
    """

    order_number = models.CharField(max_length=32, null=False, editable=False)
    user_profile = models.ForeignKey(UserProfile, on_delete=models.SET_NULL, null=True, blank=True, related_name='orders')
    full_name = models.CharField(max_length=50, null=False, blank=False)
    email = models.EmailField(max_length=254, null=False, blank=False)
    phone_number = models.CharField(max_length=20, null=False, blank=False)
    country = CountryField(blank_label='Country *', null=False, blank=False)
    postcode = models.CharField(max_length=20, null=True, blank=True)
    town_or_city = models.CharField(max_length=40, null=False, blank=False)
    street_address1 = models.CharField(max_length=80, null=False, blank=False)
    street_address2 = models.CharField(max_length=80, null=True, blank=True)
    county = models.CharField(max_length=80, null=True, blank=True)
    date = models.DateTimeField(auto_now_add=True)
    delivery_cost = models.DecimalField(max_digits=6, decimal_places=2, null=False, default=0)
    order_total = models.DecimalField(max_digits=10, decimal_places=2, null=False, default=0)
    grand_total = models.DecimalField(max_digits=10, decimal_places=2, null=False, default=0)
    original_bag = models.TextField(null=False, blank=False, default='')
    stripe_pid = models.CharField(max_length=254, null=False, blank=False, default='')

    def _generate_order_number(self):
        """Generate a random, unique order number using UUID."""
        return uuid.uuid4().hex.upper()

    def update_total(self):
        """
        Updates the grand total of the order, recalculating the order total (sum of the 
        line items), delivery cost (based on threshold), and the final grand total.
        The method also updates the delivery cost if the order total is below or above
        the free delivery threshold.

        It calls the aggregate function on the related OrderLineItem instances to 
        calculate the sum of their lineitem_total.
        """
        self.order_total = self.lineitems.aggregate(Sum('lineitem_total'))['lineitem_total__sum'] or 0
        if self.order_total < settings.FREE_DELIVERY_THRESHOLD:
            self.delivery_cost = self.order_total * settings.STANDARD_DELIVERY_PERCENTAGE / 100
        else:
            self.delivery_cost = 0
        self.grand_total = self.order_total + self.delivery_cost
        self.save()

    def save(self, *args, **kwargs):
        """Override the original save method to set the order number if it hasn't been set already."""
        if not self.order_number:
            self.order_number = self._generate_order_number()
        super().save(*args, **kwargs)

    def __str__(self):
        return self.order_number

class OrderLineItem(models.Model):
    
    order = models.ForeignKey(Order, null=False, blank=False, on_delete=models.CASCADE, related_name='lineitems')
    seed = models.ForeignKey(Seed, null=False, blank=False, on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField(null=False, blank=False, default=0)
    lineitem_total = models.DecimalField(max_digits=10, decimal_places=2, null=False, blank=False, editable=False)

    def save(self, *args, **kwargs):
        """Override the original save method to set the lineitem total and update the order total."""
        self.lineitem_total = self.seed.calculate_discounted_price() * self.quantity
        super().save(*args, **kwargs)

    def __str__(self):
        return f'{self.seed.name} on order {self.order.order_number}'
