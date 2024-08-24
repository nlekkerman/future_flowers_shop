from django import template

register = template.Library()

@register.filter(name='calc_subtotal')
def calc_subtotal(price, quantity):
    """
    Calculate the subtotal for a given price and quantity.

    Args:
    price (float): The price of a single item.
    quantity (int): The number of items.

    Returns:
    float: The subtotal amount.
    """
    try:
        return price * quantity
    except (TypeError, ValueError):
        return 0
