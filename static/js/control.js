console.log('control.js loaded'); // Log when this script is loaded

// Fetch and store seeds
export async function fetchAndStoreSeeds() {
    try {
        const response = await fetch('/syncmanager/api/get_seeds_to_localstorage/');
        if (!response.ok) {
            const responseBody = await response.text();
            throw new Error(`Failed to fetch seeds: ${response.statusText}. Response body: ${responseBody}`);
        }
        const data = await response.json();
        console.log('Fetched all seeds from server:', data.seeds);

        if (!Array.isArray(data.seeds)) {
            throw new Error('Expected `seeds` to be an array');
        }

        localStorage.setItem('seeds_data', JSON.stringify(data.seeds));
        console.log('Seeds data saved to localStorage.');

        // Return the data for use in other functions
        return data.seeds; // Return the array of seeds
    } catch (error) {
        console.error('Error fetching and storing seeds:', error);
        // Optionally return an empty array or handle the error accordingly
        return [];
    }
}
// Function to get the CSRF token from cookies (if using Django)
export function getCookie(name) {
    let cookieValue = null;
    if (document.cookie && document.cookie !== '') {
        const cookies = document.cookie.split(';');
        for (let i = 0; i < cookies.length; i++) {
            const cookie = cookies[i].trim();
            if (cookie.substring(0, name.length + 1) === (name + '=')) {
                cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                break;
            }
        }
    }
    return cookieValue;
}
export async function fetchCartData() {
    try {
        console.log('Fetching cart data...');
        
        // Fetch cart data from server
        const response = await fetch('/syncmanager/api/get_cart/');
        const data = await response.json();
        
        // Log the raw response
        console.log('Raw cart data:', data);

        if (data.error) {
            console.error('Error fetching cart:', data.error);
        } else {
            // Store cart data in local storage
            localStorage.setItem('cart', JSON.stringify(data));
            console.log('Cart data saved to local storage:', data);
        }
    } catch (error) {
        // Log any error that occurred during the fetch
        console.error('Error occurred during fetch:', error);
    }
}


// Function to send an item to the cart
export async function sendToCart(seedId, quantity) {
    try {
        const response = await fetch('/cart/api/add_to_cart/', {  // Adjust URL based on your Django configuration
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRFToken': getCsrfToken()  // Function to get CSRF token
            },
            body: JSON.stringify({
                seed_id: seedId,
                quantity: quantity
            })
        });

        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }

        const data = await response.json();
        return data;
    } catch (error) {
        console.error('Error adding item to cart:', error);
        throw error;
    }
}

export async function updateQuantityOnServer(cartId, seedId, newQuantity) {
    try {
        const response = await fetch('/cart/api/update_quantity/', {  // Adjust URL based on your Django configuration
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRFToken': getCsrfToken()  // Function to get CSRF token
            },
            body: JSON.stringify({
                cart_id: cartId,
                seed_id: seedId,
                quantity: newQuantity
            })
        });

        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }

        const data = await response.json();
        if (data.success) {
            console.log('Quantity updated successfully:', data.new_quantity);
            return data;
        } else {
            console.error('Error updating quantity:', data.error);
            throw new Error(data.error);
        }
    } catch (error) {
        console.error('Error updating quantity:', error);
        throw error;
    }
}

export async function deleteCartItemOnServer(seedId) {
    const cart = getCartFromLocalStorage();
    const cartId = cart.id || Date.now(); // Use existing cart ID or generate a new one

    try {
        const response = await fetch('/cart/api/delete_item/', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRFToken': getCsrfToken(), // Ensure you include the CSRF token
            },
            body: JSON.stringify({
                cart_id: cartId,
                seed_id: seedId
            }),
        });

        if (!response.ok) {
            throw new Error(`Error: ${response.statusText}`);
        }

        const result = await response.json();
        console.log('Server response:', result);

        if (result.success) {
            console.log('Item successfully deleted from server.');
        } else {
            console.error('Failed to delete item:', result.error);
            // Optionally handle the error (e.g., show a message to the user)
        }
    } catch (error) {
        console.error('Failed to delete item from server:', error);
        // Optionally handle the error (e.g., show a message to the user)
    }
}

// Helper function to get CSRF token from cookies
function getCsrfToken() {
    const name = 'csrftoken';
    const value = '; ' + document.cookie;
    const parts = value.split('; ' + name + '=');
    if (parts.length === 2) return parts.pop().split(';').shift();
}
// Helper function to get cart data from localStorage
function getCartFromLocalStorage() {
    const cartData = localStorage.getItem('cart');
    return cartData ? JSON.parse(cartData) : {
        items: []
    };
}