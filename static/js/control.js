export async function fetchAndStoreSeeds() {
    try {
        const response = await fetch('/syncmanager/api/get_seeds_to_localstorage/');
        if (!response.ok) {
            const responseBody = await response.text();
            throw new Error(`Failed to fetch seeds: ${response.statusText}. Response body: ${responseBody}`);
        }
        const data = await response.json();
        if (!Array.isArray(data.seeds)) {
            throw new Error('Expected `seeds` to be an array');
        }

        localStorage.setItem('seeds_data', JSON.stringify(data.seeds));

        return data.seeds; 
    } catch (error) {
        console.error('Error fetching and storing seeds:', error);
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
        const response = await fetch('/syncmanager/api/get_cart/');
        const data = await response.json();

        if (data.error) {
            console.error('Error fetching cart:', data.error);
        } else {
            localStorage.setItem('cart', JSON.stringify(data));
            
        }
    } catch (error) {
       
        console.error('Error occurred during fetch:', error);
    }
}


// Function to send an item to the cart
export async function sendToCart(seedId, quantity) {
    try {
        const response = await fetch('/cart/api/add_to_cart/', { // Adjust URL based on your Django configuration
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRFToken': getCsrfToken() // Function to get CSRF token
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
        const response = await fetch('/cart/api/update_quantity/', { // Adjust URL based on your Django configuration
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRFToken': getCsrfToken() // Function to get CSRF token
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

        if (result.success) {
            console.log('Item successfully deleted from server.');
        } else {
            console.error('Failed to delete item:', result.error);
            
        }
    } catch (error) {
        console.error('Failed to delete item from server:', error);
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

        if (!response.ok) {
            console.error('Failed to fetch user ID, redirecting to login or another error occurred:', response.status);
            // Optionally handle specific status codes
            if (response.status === 401) {
                // User is not authenticated, redirect to login
                window.location.href = '/custom_accounts/login/';
            }
            return null; // Exit function if response is not okay
        }

        const data = await response.json();

        if (data.user_id !== undefined) {
            localStorage.setItem('userId', data.user_id); // Store user ID in local storage

            return data.user_id;
        } else {
            console.error('Failed to fetch user ID:', data);
            return null; // Handle unexpected data format
        }
    } catch (error) {
        console.error('Network error while fetching user ID:', error);
        return null; // Handle network error
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
            body: JSON.stringify({
                content: messageContent
            })
        });

        // Check if the response is okay
        if (!response.ok) {
            const errorData = await response.json(); // Try to parse the error message
            throw new Error(errorData.error || 'Network response was not ok');
        }

        // Parse the JSON response
        const data = await response.json();
        return data; 
    } catch (error) {
        console.error('Error sending message:', error);
        return {
            success: false,
            error: error.message
        };
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

        if (data.success) {
            
            return data.messages; 
            
        } else {
            alert(`Error: ${data.error}`); 
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

            
            document.querySelectorAll('.unseen-messages-count').forEach(element => {
                element.innerText = unseenMessages; 
            });

           // Select the single notification area element
           const notificationArea = document.getElementById('notification-area');

           if (notificationArea) {
               
               if (unseenMessages > 0) {
                   notificationArea.style.backgroundColor = 'red'; 
               } else {
                   notificationArea.style.backgroundColor = 'transparent';
               }

           } else {
               console.warn("Notification area with ID 'notification-area' not found.");
           }

        } else {
            console.error('Failed to fetch message counts:', data);
        }
    } catch (error) {
        console.error('Error fetching message counts:', error);
    }
}


document.addEventListener('DOMContentLoaded', function () {
    const searchIcon = document.getElementById('searchIcon');
    const searchContainer = document.getElementById('searchContainer');

    // Add a click event listener to the search icon
    searchIcon.addEventListener('click', function () {
     
        if (searchContainer.style.display === 'none' || searchContainer.style.display === '') {
            searchContainer.classList.add('show'); 
            searchContainer.style.display = 'block'; 
            searchIcon.style.opacity = '0';
        } else {
            searchContainer.classList.remove('show');
            setTimeout(() => { 
                searchContainer.style.display = 'none';
                searchIcon.style.opacity = '1';
            }, 300); 
        }
    });
});

document.addEventListener('DOMContentLoaded', function () {
    const slides = document.querySelectorAll('.seed-slide');
    const totalSlides = slides.length;
    let currentSlideIndex = 0;
    const slider = document.querySelector('.seeds-slider');

    console.log(`Total slides: ${totalSlides}`); // Log total slides found

    // Check if slider container is found
    if (!slider) {
        console.error("Slider container '.seeds-slider' not found!");
        return;
    }

    // Function to move to the next slide
    function goToNextSlide() {
        console.log('Moving to next slide...');
        if (currentSlideIndex === totalSlides - 1) {
            currentSlideIndex = 0;
        } else {
            currentSlideIndex++;
        }
        updateSliderPosition();
    }

    // Function to move to the previous slide
    function goToPreviousSlide() {
        console.log('Moving to previous slide...');
        if (currentSlideIndex === 0) {
            currentSlideIndex = totalSlides - 1;
        } else {
            currentSlideIndex--;
        }
        updateSliderPosition();
    }

    // Function to update the slider's position
    function updateSliderPosition() {
        console.log(`Current Slide Index: ${currentSlideIndex}`);
        const offset = -currentSlideIndex * 100; // Move the slider by 100% of the current index
        slider.style.transform = `translateX(${offset}%)`;
    }

    // Event listeners for controls
    const nextButton = document.querySelector('.next-btn');
    const prevButton = document.querySelector('.prev-btn');

    if (nextButton) {
        nextButton.addEventListener('click', goToNextSlide);
    } else {
        console.error("Next button '.next-btn' not found!");
    }

    if (prevButton) {
        prevButton.addEventListener('click', goToPreviousSlide);
    } else {
        console.error("Previous button '.prev-btn' not found!");
    }

    // Set an interval for auto sliding (optional)
    setInterval(goToNextSlide, 5000); // Change slide every 5 seconds

    // Add event listeners to each seed item to redirect on click
    const seedItems = document.querySelectorAll('.seed-item a');
    console.log(`Found ${seedItems.length} seed items`);
    seedItems.forEach(item => {
        item.addEventListener('click', function (event) {
            console.log('Redirecting to /seeds/?show_seeds=true');
            window.location.href = '/seeds/?show_seeds=true';
            event.preventDefault(); // Prevent the default link behavior
        });
    });
});
