

export function getCartFromLocalStorage() {
    return JSON.parse(localStorage.getItem('cart')) || { items: [] };
}
