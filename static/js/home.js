import {
    getCookie,
    fetchCartData,
    fetchUserId,
    fetchConversations,
    sendMessage,
    fetchUsername,
    fetchMessages,
    checkIfSuperUser,
    fetchMessageCounts
} from './control.js';
let loggedInUsername;
window.onload = async () => {
    try {
        const userId = await fetchUserId(); // Fetch user ID
const loggedInUsername = await fetchUsername(); // Fetch username here
await fetchMessageCounts();

const chatContainer = document.getElementById('chat-container');
const messagesIcon = document.getElementById('messagesIcon');
const adminMessagesIcon = document.getElementById('admin-message-icon');

// Function to toggle visibility of the chat container
const toggleChatContainerVisibility = () => {
    if (chatContainer.style.display === "block") {
        chatContainer.style.display = "none"; // Hide the chat container
    } else {
        chatContainer.style.display = "block"; // Show the chat container
    }
};

if (adminMessagesIcon) {
    adminMessagesIcon.addEventListener('click', async () => {
        toggleChatContainerVisibility(); // Toggle visibility on icon click
        console.log('Admin Message icon clicked.'); // For debugging
        await fetchConversations(userId); // Fetch conversations for superuser
        displayConversationsFromLocalStorage(); // Display conversations
    });
} else {
    console.error('Admin message icon not found.');
}

// Check if messagesIcon is found
if (messagesIcon) {
    messagesIcon.addEventListener('click', async () => {
        console.log('Message icon clicked.'); // For debugging
        const userMessages = await fetchUserMessages(userId);
        displayUserMessages(userMessages, loggedInUsername);
        toggleChatContainerVisibility(); // Toggle visibility when user messages icon is clicked
    });
} else {
    console.error('Messages icon not found.');
}

        if (userId) {
            const isSuperUser = await checkIfSuperUser(); // Check superuser status

            if (isSuperUser) {
                await fetchConversations(userId); // Fetch conversations for superuser
                displayConversationsFromLocalStorage(); // Display conversations
            } else {
                // Fetch and display messages for regular user
                const userMessages = await fetchUserMessages(userId);
                displayUserMessages(userMessages, loggedInUsername);
            }
        } else {
            console.error('User ID is null or undefined. Cannot fetch conversations.');
        }
    } catch (error) {
        console.error('Error during onload initialization:', error);
    }
};


function updateCartTotalUI() {
    const cartTotalElement = document.getElementById('cart-total');

    // Clear the cart total before updating
    if (cartTotalElement) {
        cartTotalElement.textContent = '0.00'; // Reset the cart total to zero
    }

    // Fetch the latest cart data and update the cart total
    const cartData = JSON.parse(localStorage.getItem('cart')) || {
        items: []
    };
    const totalPrice = cartData.items.reduce((total, item) => total + (item.total_price || 0), 0);

    if (cartTotalElement) {
        cartTotalElement.textContent = totalPrice.toFixed(2);
    }
}

document.addEventListener('DOMContentLoaded', function () {
    updateCartTotalUI(); // Update cart total when the page loads
    // Run the function when the page loads
    updateIconsBasedOnSuperUser();

});

document.addEventListener('DOMContentLoaded', () => {
    const viewCartButton = document.getElementById('cart-button');

    if (viewCartButton) {
        viewCartButton.addEventListener('click', () => {
            window.location.href = '/cart/'; // Redirect to cart page
        });
        console.log("Cart button found, event listener attached.");
    }
});

document.getElementById('logout-button').addEventListener('click', () => {
    // Clear cart data from localStorage
    localStorage.removeItem('cart');

    // Set cart total to 0 in the UI
    const cartTotalElement = document.getElementById('cart-total');
    if (cartTotalElement) {
        cartTotalElement.textContent = `$0.00`; // Reset the cart total display
    }

    console.log('Cart cleared and total set to $0.00 after logout.');

    // Optionally, proceed with your logout logic here (e.g., redirect or refresh the page)
    // Example:
    // window.location.href = '/logout-url/';
});

document.getElementById('login-button').addEventListener('click', async () => {
    console.log('Login button clicked. Fetching cart data...');

    try {
        // Call fetchCartData() to retrieve the cart data after login
        await fetchCartData();
        console.log('Cart data fetched successfully after login.');
    } catch (error) {
        console.error('Error fetching cart data after login:', error);
    }
});

export function displayConversationsFromLocalStorage() {
    const storedConversations = localStorage.getItem('userConversations');

    console.info('Attempting to load conversations from local storage.');

    if (!storedConversations) {
        console.warn('No conversations found in local storage.');
        return;
    }

    let conversations;
    try {
        conversations = JSON.parse(storedConversations);
        console.info(`Parsed ${conversations.length} conversations from local storage.`);
    } catch (error) {
        console.error('Error parsing conversations from local storage:', error);
        return;
    }

    const chatContainer = document.getElementById('chat-container');

    if (!chatContainer) {
        console.error('Chat container not found.');
        return;
    }

    chatContainer.innerHTML = '';

    if (conversations.length === 0) {
        console.warn('No conversations to display.');
        chatContainer.innerHTML = '<p>No conversations found.</p>';
        return;
    }


    conversations.forEach((conversation) => {
        console.info(`Displaying conversation:`, conversation);

        const conversationDiv = document.createElement('div');
        conversationDiv.className = 'conversation';
        conversationDiv.style.cursor = 'pointer';
        conversationDiv.style.marginBottom = '10px';

        conversationDiv.innerHTML = `
            <strong>User:</strong> ${conversation.user}<br>
            <strong>Superuser:</strong> ${conversation.superuser}<br>
            <strong>Started At:</strong> ${new Date(conversation.started_at).toLocaleString()}
        `;

        conversationDiv.addEventListener('click', () => loadConversationMessages(conversation.id, loggedInUsername));

        chatContainer.appendChild(conversationDiv);
    });

    console.info(`Displayed ${conversations.length} conversations from local storage.`);
}
async function loadConversationMessages(conversationId, loggedInUsername) {
    try {
        const response = await fetch(`/syncmanager/api/get_conversation_messages/${conversationId}/`);

        if (!response.ok) throw new Error('Network response was not ok');

        const responseData = await response.json();
        console.log('Parsed JSON response:', responseData);

        if (!Array.isArray(responseData.messages)) {
            throw new Error('Invalid response format: expected an array of messages');
        }

        const messages = responseData.messages;

        let messageModal = document.getElementById('message-modal');
        if (!messageModal) {
            messageModal = document.createElement('div');
            messageModal.id = 'message-modal';
            messageModal.className = 'modal-chat';
            messageModal.innerHTML = `
                <div class="modal-content super-chat-window">
                    <span class="close-modal-button close-chat-window">&times;</span>
                    <div id="modal-message-list" class="message-scroll-container"></div>
                </div>
                <div class="chat-footer-input">
                    <input type="text" id="message-input" class="text-type-box" placeholder="Type your message..." />
                    <button id="send-message-button" class="send-message-action">Send</button>
                </div>
            `;
            document.body.appendChild(messageModal);
        }

        const modalMessageList = document.getElementById('modal-message-list');
        modalMessageList.innerHTML = ''; // Clear previous messages

        // Display existing messages
        messages.forEach((message) => {
            const messageDiv = document.createElement('div');
            const messageClass = message.sender === loggedInUsername ? 'message-right' : 'message-left';
            messageDiv.className = `chat-message ${messageClass}`;
            messageDiv.innerHTML = `
                <strong>${message.sender}:</strong> ${message.content}<br>
                <em>${new Date(message.sent_at).toLocaleString()}</em>
            `;
            modalMessageList.appendChild(messageDiv);
        });

        modalMessageList.scrollTop = modalMessageList.scrollHeight; // Scroll to bottom
        messageModal.style.display = 'block';

        // Close modal functionality
        document.querySelector('.close-chat-window').onclick = () => {
            messageModal.style.display = 'none';
        };

        window.onclick = (event) => {
            if (event.target === messageModal) {
                messageModal.style.display = 'none';
            }
        };

        // Set up the send button click handler
        const sendButton = document.getElementById('send-message-button');
        sendButton.onclick = () => {
            console.log('Username before sending message:', loggedInUsername); // Debugging
            handleSendMessage(conversationId, loggedInUsername);
        };

    } catch (error) {
        console.error('Error loading conversation messages:', error);
    }
}

async function handleSendMessage(conversationId, loggedInUsername) {
    const messageInput = document.getElementById('message-input');
    const messageContent = messageInput.value.trim();

    if (messageContent) {
        console.log(`Message sent: ${messageContent}`); // Log the message content

        // Call the sendMessage function
        const data = await sendMessage(conversationId, messageContent);

        // Log the entire response data for debugging
        console.log('Data returned from sendMessage:', data);

        // Check if data is defined and has a success property
        if (data && data.success) {
            const modalMessageList = document.getElementById('modal-message-list');
            const newMessageDiv = document.createElement('div');
            newMessageDiv.className = `chat-message message-right`; // Assuming sent messages go to the right
            newMessageDiv.innerHTML = `
                <strong>${loggedInUsername}:</strong> ${messageContent}<br>
                <em>${new Date().toLocaleString()}</em>
            `;
            modalMessageList.appendChild(newMessageDiv);
            modalMessageList.scrollTop = modalMessageList.scrollHeight; // Scroll to bottom
        } else {
            // Log the error if data is not as expected
            console.error('Failed to send message:', data ? data.error : 'Unknown error');
        }

        messageInput.value = ''; // Clear the input field after sending
    } else {
        console.log('Input is empty, no message sent.');
    }
}
async function displayUserMessages(messages, loggedInUsername) {
    console.log('Entering displayUserMessages function');
    console.log('Logged in username:', loggedInUsername);
    console.log('Messages received:', messages); // Debugging output

    const chatContainer = document.getElementById('chat-container');
    if (!chatContainer) {
        console.error('Chat container not found.');
        return;
    }

    // Create or update the message modal
    let messageModal = document.getElementById('message-modal');
    if (!messageModal) {
        messageModal = document.createElement('div');
        messageModal.id = 'message-modal';
        messageModal.className = 'modal-chat';
        messageModal.innerHTML = `
            <div class="modal-content super-chat-window">
                <span class="close-modal-button close-chat-window">&times;</span>
                <div id="modal-message-list" class="message-scroll-container"></div>
            </div>
            <div class="chat-footer-input">
                <input type="text" id="message-input" class="text-type-box" placeholder="Type your message..." />
                <button id="send-message-button" class="send-message-action">Send</button>
            </div>
        `;
        document.body.appendChild(messageModal);
    }

    const modalMessageList = document.getElementById('modal-message-list');
    modalMessageList.innerHTML = ''; // Clear previous messages

    if (messages.length === 0) {
        console.warn('No messages to display.');
        modalMessageList.innerHTML = '<p>No messages found.</p>';
        messageModal.style.display = 'block'; // Show the modal even if no messages
        return;
    }

    // Extract conversationId from the first message
    const conversationId = messages.length > 0 ? messages[0].conversation_id : null; // Ensure you're using conversation_id

    // Display existing messages
    messages.forEach((message) => {
        console.info(`Displaying message:`, message);

        const messageDiv = document.createElement('div');
        const messageClass = message.sender === loggedInUsername ? 'message-right' : 'message-left';
        messageDiv.className = `chat-message ${messageClass}`;
        messageDiv.innerHTML = `
            <strong>${message.sender}:</strong> ${message.content}<br>
            <em>${new Date(message.sent_at).toLocaleString()}</em>
        `;

        modalMessageList.appendChild(messageDiv);
    });

    modalMessageList.scrollTop = modalMessageList.scrollHeight; // Scroll to bottom
    messageModal.style.display = 'block'; // Show the modal

    // Close modal functionality
    document.querySelector('.close-chat-window').onclick = () => {
        messageModal.style.display = 'none';
    };

    window.onclick = (event) => {
        if (event.target === messageModal) {
            messageModal.style.display = 'none';
        }
    };

    // Set up the send button click handler
    const sendButton = document.getElementById('send-message-button');
    sendButton.onclick = () => {
        if (conversationId) {
            console.log('Username before sending message:', loggedInUsername); // Debugging
            handleSendMessage(conversationId, loggedInUsername);
        } else {
            console.error('Conversation ID is not available.');
        }
    };
    // Call the function to update message seen status
    const messageIds = messages.map(message => message.id);
    await updateMessageStatus(messageIds, true); // Update to seen
}
async function updateIconsBasedOnSuperUser() {
    console.log("Starting to check user status..."); // Log when the function starts
    const result = await checkIfSuperUser();

    if (result === null) {
        // Handle failure, e.g., by logging or showing an error message
        console.error('Failed to fetch user status.');
        return;
    }

    console.log("User status fetched:", result); // Log the result of the user status check

    const {
        isSuperUser,
        isAuthenticated
    } = result;

    const notificationArea = document.getElementById('notification-area');
    const adminIcon = document.getElementById('admin-message-icon');
    const messageIcon = document.getElementById('messagesIcon');

    if (!isAuthenticated) {
        console.log("User is not authenticated."); // Log when the user is not authenticated
        // If the user is not authenticated, hide the notification area
        notificationArea.style.display = 'none';
    } else {
        console.log("User is authenticated."); // Log when the user is authenticated
        // If the user is authenticated, show the notification area
        notificationArea.style.display = 'block';

        if (isSuperUser) {
            console.log("User is a superuser."); // Log when the user is a superuser
            // Show admin icon for superusers
            adminIcon.style.display = 'block';
            messageIcon.style.display = 'none';
        } else {
            console.log("User is a regular authenticated user."); // Log when the user is a regular authenticated user
            // Show message icon for regular authenticated users
            messageIcon.style.display = 'block';
            adminIcon.style.display = 'none';
        }
    }
}

async function fetchUserMessages(userId) {
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

async function updateMessageStatus(messageIds, isSeen) {
    try {
        const response = await fetch('/syncmanager/api/update-message-status/', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRFToken': getCookie('csrftoken') // Function to get CSRF token
            },
            body: JSON.stringify({
                messageIds: messageIds,
                isSeen: isSeen
            }),
        });

        if (!response.ok) {
            const errorData = await response.json();
            console.error('Error updating message status:', errorData);
        } else {
            const successData = await response.json();
            console.log('Success:', successData.message);
        }
    } catch (error) {
        console.error('Network error:', error);
    }
}