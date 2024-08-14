# cart/models.py

from django.db import models
from django.contrib.auth.models import User
from seeds.models import Seed

class Cart(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def get_total_price(self):
        return sum(item.get_total_price() for item in self.items.all())

    def get_total_discount(self):
        return sum(item.get_discount_amount() for item in self.items.all())

    def __str__(self):
        return f"Cart {self.id} for {self.user.username}"

class CartItem(models.Model):
    cart = models.ForeignKey(Cart, related_name='items', on_delete=models.CASCADE)
    seed = models.ForeignKey(Seed, on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField(default=1)

    def get_total_price(self):
        return self.seed.calculate_discounted_price() * self.quantity

    def get_discount_amount(self):
        if self.seed.has_discount():
            return (self.seed.price - self.seed.calculate_discounted_price()) * self.quantity
        return 0

    def __str__(self):
        return f"{self.quantity} of {self.seed.name}"
