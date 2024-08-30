import logging

logger = logging.getLogger(__name__)

def get_max_possible_quantity(in_stock, current_quantity):
    """
    Calculate the maximum possible quantity that can be set for a cart item.
    """
    max_quantity = in_stock + current_quantity
    logger.debug(f"Calculated max possible quantity: {max_quantity} (In stock: {in_stock}, Current quantity: {current_quantity})")
    return max_quantity