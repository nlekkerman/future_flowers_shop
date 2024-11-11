from django.db import models
from django.contrib.auth.models import User
from seeds.models import Seed
from decimal import Decimal


class Cart(models.Model):
    """
    Represents a shopping cart for a user or an anonymous session. The cart holds
    the list of items (CartItems) that the user has added and tracks the total 
    price, discounts, and delivery costs.

    Attributes:
        user (OneToOneField): A reference to the User model if the cart belongs to 
                               an authenticated user. Otherwise, the cart is linked 
                               to an anonymous session.
        session_id (CharField): A session ID for anonymous users, used to track the cart.
        created_at (DateTimeField): Timestamp when the cart was created.
        updated_at (DateTimeField): Timestamp when the cart was last updated.
        last_modified (DateTimeField): Timestamp of the most recent modification to the cart.
        deleted (BooleanField): A flag indicating whether the cart has been marked as deleted.
    """
    user = models.OneToOneField(User, null=True, blank=True, on_delete=models.CASCADE)
    session_id = models.CharField(max_length=255, null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    last_modified = models.DateTimeField(auto_now=True)
    deleted = models.BooleanField(default=False)

    def get_total_price(self):
        """
        Calculates the total price of all items in the cart by summing the prices 
        of each cart item (including discounts).

        Returns:
            Decimal: The total price of all items in the cart.
        """
        return sum(item.get_total_price() for item in self.items.all())


    def get_total_discount(self):
        """
        Calculates the total discount applied to all items in the cart.

        Returns:
            Decimal: The total discount applied across all items in the cart.
        """
        return sum(item.get_discount_amount() for item in self.items.all())


    def get_delivery_cost(self):
        """
        Determines the delivery cost based on the total price of the cart.
        If the total price is below $50, the delivery cost is $5; otherwise, it is free.

        Returns:
            Decimal: The delivery cost, either $0 or $5, based on the cart's total price.
        """
        total_price = Decimal(self.get_total_price())
        if total_price < Decimal('50.00'):
            return Decimal('5.00')
        return Decimal('0.00')


    def get_grand_total(self):
        """
        Calculates the grand total of the cart, including the total price of items 
        and any applicable delivery costs.

        Returns:
            Decimal: The grand total for the cart, which is the sum of the total price 
            and delivery cost.
        """
        return self.get_total_price() + self.get_delivery_cost()


    def __str__(self):
        """
        Returns a string representation of the cart. If the cart belongs to a user, 
        the string includes the user's username; otherwise, it includes the session ID.

        Returns:
            str: The string representation of the cart, either for a user or session.
        """
        if self.user:
            return f"Cart {self.id} for {self.user.username}"
        return f"Cart {self.id} for session {self.session_id}"
     
class CartItem(models.Model):
    """
    Represents an item in the cart. A cart item links to a specific seed and tracks 
    its quantity in the cart. It also includes functionality to calculate the total 
    price and the discount amount for the item.

    Attributes:
        cart (ForeignKey): A reference to the Cart that the item belongs to.
        seed (ForeignKey): A reference to the Seed that this item represents.
        quantity (PositiveIntegerField): The number of seeds in this cart item.
        last_modified (DateTimeField): Timestamp of the last modification to the cart item.
        deleted (BooleanField): A flag indicating whether the cart item has been marked as deleted.
    """
    cart = models.ForeignKey(Cart, related_name='items', on_delete=models.CASCADE)
    seed = models.ForeignKey(Seed, on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField(default=1)
    last_modified = models.DateTimeField(auto_now=True)  
    deleted = models.BooleanField(default=False)

    def get_total_price(self):
        """
        Calculates the total price for this cart item, considering the quantity of the item
        and its discounted price (if any).

        Returns:
            Decimal: The total price for this item based on quantity and its price after 
            discount.
        """
        return self.seed.calculate_discounted_price() * self.quantity

    def get_discount_amount(self):
        """
        Calculates the discount amount for this cart item. If the seed has a discount,
        it computes the difference between the original price and the discounted price, 
        multiplied by the quantity.

        Returns:
            Decimal: The total discount amount for this cart item, or 0 if there is no discount.
        """
        if self.seed.has_discount():
            return (self.seed.price - self.seed.calculate_discounted_price()) * self.quantity
        return 0

    def __str__(self):
        """
        Returns a string representation of the cart item, showing the quantity and 
        the name of the seed.

        Returns:
            str: A string representation of the cart item, including the quantity and seed name.
        """
        return f"{self.quantity} of {self.seed.name}"