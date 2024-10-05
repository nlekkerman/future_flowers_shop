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
export async function fetchUserMessages(userId) {
    try {
        const response = await fetch(`/syncmanager/api/get_user_messages/`);
        if (!response.ok) throw new Error('Network response was not ok');

        const responseData = await response.json();
        console.log('Fetched user messages:', responseData);

        if (!Array.isArray(responseData.messages)) {
            throw new Error('Invalid response format: expected an array of messages');
        }

        return responseData.messages; // Return the messages array
    } catch (error) {
        console.error('Error fetching user messages:', error);
        return []; // Return an empty array on error
    }
}

export async function fetchConversations(userId) {
    try {
        const response = await fetch(`/syncmanager/api/get_user_conversations/${userId}/`);
        const data = await response.json();

        if (response.ok) {
            // Store conversations in localStorage
            localStorage.setItem('userConversations', JSON.stringify(data.conversations));
           
        } else {
            console.error('Error fetching conversations:', data.error);
        }
    } catch (error) {
        console.error('Network error while fetching conversations:', error);
    }
}
export async function fetchUserId() {
    try {
        const response = await fetch('/syncmanager/api/get_user_id/');
        const data = await response.json();

        if (response.ok && data.user_id) {
            localStorage.setItem('userId', data.user_id); // Store user ID in local storage
            return data.user_id;
        } else {
            console.error('Failed to fetch user ID:', data);
            return null;
        }
    } catch (error) {
        console.error('Network error while fetching user ID:', error);
        return null;
    }
}


export async function sendMessage(conversationId, messageContent) {
    try {
        const response = await fetch(`/syncmanager/api/send_message/${conversationId}/`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRFToken': getCookie('csrftoken') // If you're using CSRF protection
            },
            body: JSON.stringify({ content: messageContent })
        });

        // Check if the response is okay
        if (!response.ok) {
            const errorData = await response.json(); // Try to parse the error message
            throw new Error(errorData.error || 'Network response was not ok');
        }

        // Parse the JSON response
        const data = await response.json();
        console.log('Message sent successfully:', data);
        return data; // Return the data for further handling
    } catch (error) {
        console.error('Error sending message:', error);
        return { success: false, error: error.message }; // Return structured error
    }
}
export async function fetchUsername() {
    const response = await fetch('/syncmanager/api/get_username');
    const data = await response.json();
    return data.username;
}
export async function fetchMessages(conversationId) {
    try {
        const response = await fetch(`/syncmanager/api/get_conversation_messages/${conversationId}/`);

        // Check if the response is OK (status code 200)
        if (!response.ok) {
            throw new Error(`Network response was not ok: ${response.status} ${response.statusText}`);
        }

        // Parse the JSON response
        const data = await response.json();

        // Check for success in the response
        if (data.success) {
            console.log('Fetched messages:', data.messages);  // Log messages to the console
            return data.messages;  // Return the messages for further use
        } else {
            alert(`Error: ${data.error}`);  // Alert if there's an error
            return [];
        }
    } catch (error) {
        console.error('Error fetching messages:', error);
        alert('Failed to fetch messages. Please try again later.');
        return [];
    }
}

export async function checkIfSuperUser() {
    try {
        const response = await fetch('/syncmanager/api/check_superuser/');
        
        if (!response.ok) {
            console.error('Failed to check superuser status:', response.status);
            return null; // Return null to indicate failure
        }

        const data = await response.json();
        return {
            isSuperUser: data.isSuperUser,
            isAuthenticated: data.isAuthenticated,
        }; // Return both superuser and authenticated status
    } catch (error) {
        console.error('Error checking superuser status:', error);
        return null; // Return null in case of an error
    }
}

export async function fetchMessageCounts() {
    try {
        const response = await fetch('/syncmanager/api/message_counts/');
        const data = await response.json();

        if (response.ok) {
            const unseenMessages = data.unseenMessages;

            console.log("Unseen messages: ", unseenMessages);

            // Ensure you are selecting the correct class or ID.
            // If it's a class, use `.unseen-messages-count`, if an ID, use `#unseen-messages-count`.
            document.querySelectorAll('.unseen-messages-count').forEach(element => {
                element.innerText = unseenMessages;  // Update innerText for each matched element
            });

        } else {
            console.error('Failed to fetch message counts:', data);
        }
    } catch (error) {
        console.error('Error fetching message counts:', error);
    }
}


document.addEventListener('DOMContentLoaded', function() {
    const searchIcon = document.getElementById('searchIcon');
    const searchContainer = document.getElementById('searchContainer');

    // Add a click event listener to the search icon
    searchIcon.addEventListener('click', function() {
        // Log to console for debugging
        console.log("SSSSSEEEEEEEAAAAAAARRRRRRCCCCCCCCCHHHHH");

        // Check the current display state and toggle
        if (searchContainer.style.display === 'none' || searchContainer.style.display === '') {
            searchContainer.classList.add('show'); // Add class to show
            searchContainer.style.display = 'block'; // Temporarily set display to block
            searchIcon.style.opacity = '0'; // Hide the icon
        } else {
            searchContainer.classList.remove('show'); // Remove class to hide
            setTimeout(() => { // Wait for transition to finish before hiding
                searchContainer.style.display = 'none'; // Set display to none after fade
                searchIcon.style.opacity = '1'; // Show the icon again
            }, 300); // Match timeout to CSS transition duration
        }
    });
});

