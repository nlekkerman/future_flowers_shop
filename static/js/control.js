console.log('control.js loaded'); // Log when this script is loaded

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
        // Optionally return empty array or handle the error accordingly
        return [];
    }
}

export async function fetchAndStoreCart() {
    try {
        const response = await fetch('/syncmanager/api/cart/');
        if (!response.ok) {
            const responseBody = await response.text();
            throw new Error(`Failed to fetch cart: ${response.statusText}. Response body: ${responseBody}`);
        }
        const data = await response.json();
        console.log('Fetched cart from server:', data);

        if (data.cart_id !== null) {
            localStorage.setItem('cart_data', JSON.stringify(data));
            console.log('Cart data saved to localStorage.');
            return data; // Return the cart data for further use
        } else {
            console.log('No cart data to save.');
            return null; // Indicate no data to use
        }

    } catch (error) {
        console.error('Error fetching and storing cart:', error);
        return null; // Return null in case of an error
    }
}
