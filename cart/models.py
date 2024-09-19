from django.db import models
from django.contrib.auth.models import User
from seeds.models import Seed
from decimal import Decimal


class Cart(models.Model):
    user = models.OneToOneField(User, null=True, blank=True, on_delete=models.CASCADE)
    session_id = models.CharField(max_length=255, null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    last_modified = models.DateTimeField(auto_now=True)  # Automatically set to the current date/time on save
    deleted = models.BooleanField(default=False)

    def get_total_price(self):
        return sum(item.get_total_price() for item in self.items.all())

    def get_total_discount(self):
        return sum(item.get_discount_amount() for item in self.items.all())

    def get_delivery_cost(self):
        # Example logic; modify as needed
        total_price = Decimal(self.get_total_price())
        if total_price < Decimal('50.00'):
            return Decimal('5.00')  # Flat rate for orders under $50
        return Decimal('0.00')  # Free delivery for orders $50 and above

    def get_grand_total(self):
        return self.get_total_price() + self.get_delivery_cost()
    def __str__(self):
        if self.user:
            return f"Cart {self.id} for {self.user.username}"
        return f"Cart {self.id} for session {self.session_id}"
     
class CartItem(models.Model):
    cart = models.ForeignKey(Cart, related_name='items', on_delete=models.CASCADE)
    seed = models.ForeignKey(Seed, on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField(default=1)
    last_modified = models.DateTimeField(auto_now=True)  # Automatically set to the current date/time on save
    deleted = models.BooleanField(default=False)

    def get_total_price(self):
        return self.seed.calculate_discounted_price() * self.quantity

    def get_discount_amount(self):
        if self.seed.has_discount():
            return (self.seed.price - self.seed.calculate_discounted_price()) * self.quantity
        return 0

    def __str__(self):
        return f"{self.quantity} of {self.seed.name}"