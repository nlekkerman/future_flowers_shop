import {
    getCookie,
    fetchCartData,
    fetchUserId,
    fetchConversations,
    sendMessage,
    fetchUsername,
    checkIfSuperUser,
    fetchMessageCounts,
    fetchAndStoreSeeds
} from './control.js';
let loggedInUsername, loadingOverlay, loadingText;

window.onload = async () => {

    try {
        const userId = await fetchUserId(); // Fetch user ID
        loggedInUsername = await fetchUsername(); // Fetch username here
        await fetchMessageCounts();
        updateIconsBasedOnSuperUser();
        await fetchCartData();
        await fetchAndStoreSeeds();



        toggleCartButtonVisibility();

        const chatContainer = document.getElementById('chat-container');
        const messagesIcon = document.getElementById('messagesIcon');
        const adminMessagesIcon = document.getElementById('admin-message-icon');



        const toggleChatContainerVisibility = () => {
            // Add condition to check if userId is 1
            if (userId !== 1) {
                return; // Do nothing if userId is not 1
            }

            if (chatContainer.style.display === "block") {
                chatContainer.style.display = "none"; 
            } else {
                chatContainer.style.display = "block"; 
            }
        };

        if (adminMessagesIcon) {
            adminMessagesIcon.addEventListener('click', async () => {
                toggleChatContainerVisibility();
                await fetchConversations(userId); 
                displayConversationsFromLocalStorage(); 
            });
        } else {
            console.error('Admin message icon not found.');
        }

        if (messagesIcon) {
            messagesIcon.addEventListener('click', async () => {
                const userMessages = await fetchUserMessages(userId);
                displayUserMessages(userMessages, loggedInUsername);
                toggleChatContainerVisibility(); 
            });
        } else {
            console.error('Messages icon not found.');
        }

        if (userId) {
            const isSuperUser = await checkIfSuperUser(); 

            if (isSuperUser) {
                await fetchConversations(userId); 
                displayConversationsFromLocalStorage(); 
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
function showModal() {
    const modal = document.getElementById('login-modal');
    modal.classList.remove('hide'); 
    modal.classList.add('show'); 
}

// Hide the modal
function hideModal() {
    const modal = document.getElementById('login-modal');
    modal.classList.remove('show'); 
    modal.classList.add('hide');
}
/*
 * This script runs when the DOM is fully loaded and parsed.
 * It creates a modal for displaying messages and handles 
 * various interactions related to seed management, including 
 * fetching seed data, editing seeds, and deleting seeds.
 *
 * Key functionalities include:
 * - Creating and displaying a modal for messages
 * - Fetching seed data from the server
 * - Displaying seeds in a list format
 * - Handling editing and deletion of seed entries
 * - Managing CSRF tokens for secure AJAX requests
 */
document.addEventListener("DOMContentLoaded", async function () {
    
    // Create the message modal container
    const messageModal = document.createElement('div');
    messageModal.id = 'modal-overlay-background'; // Three-word ID
    messageModal.className = 'modal-overlay-background'; // Three-word class name
    messageModal.style.display = 'none';
    messageModal.style.position = 'fixed';
    messageModal.style.zIndex = '1000';
    messageModal.style.left = '0';
    messageModal.style.top = '0';
    messageModal.style.width = '100%';
    messageModal.style.height = '100%';
    messageModal.style.backgroundColor = 'rgba(0, 0, 0, 0.5)';
    messageModal.style.justifyContent = 'center';
    messageModal.style.alignItems = 'center';

    // Create the modal content box
    const modalContent = document.createElement('div');
    modalContent.className = 'modal-box-content'; // Three-word class name


    // Create the modal message paragraph
    const modalMessage = document.createElement('p');

    // Create the close button
    const closeButton = document.createElement('button');
    closeButton.className = 'button-close-modal'; // Three-word class name
    closeButton.textContent = 'Close';
    closeButton.onclick = function () {
        messageModal.style.display = 'none'; // Close the modal
    };

    // Append the message and close button to the modal content
    modalContent.appendChild(modalMessage);
    modalContent.appendChild(closeButton);

    // Append the modal content to the modal container
    messageModal.appendChild(modalContent);

    // Add the modal container to the body
    document.body.appendChild(messageModal);

    // Function to display the message modal
    function showMessageAdmin(message) {
        modalMessage.textContent = message; // Set the message text
        messageModal.style.display = 'flex'; // Show the modal
    }


    fetch('/seeds/api/seeds/')
    .then(response => {
        console.log('Fetch response status:', response.status);
        return response.json();
    })
    .then(data => {
        console.log('Data received from API:', data);  // Log the entire response data

        const seedListContainer = document.getElementById('seed-list');
        if (!seedListContainer) {
            console.error('Element with ID "seed-list" not found in the DOM.');
            return;
        }

        // Clear existing content
        seedListContainer.innerHTML = '';

        // Check if the data was successful
        if (data.success) {
            console.log('Data success status:', data.success);

            // Check if seeds exist
            if (!data.seeds || data.seeds.length === 0) {
                console.warn('No seeds found in the data.');
                const noSeedsItem = document.createElement('li');
                noSeedsItem.textContent = 'No seeds available.';
                seedListContainer.appendChild(noSeedsItem);
                return;
            }

            // Loop through each seed in data.seeds
            data.seeds.forEach(seed => {
                console.log('Processing seed:', seed);

                // Create list item
                const listItem = document.createElement('li');
                listItem.className = 'seed-list-item';

                // Create a span for seed name
                const seedName = document.createElement('span');
                seedName.className = 'seed-name';
                seedName.textContent = `${seed.name} (${seed.scientific_name})`;

                // Create Edit link
                const editLink = document.createElement('a');
                editLink.textContent = 'Edit';
                editLink.className = 'edit-link';

                // Event listener to open the modal and populate data
                editLink.addEventListener('click', function (event) {
                    event.preventDefault();
                    console.log('Edit link clicked for seed:', seed.name);
                    openEditSeedModal(seed);
                });

                // Create Delete link
                const deleteLink = document.createElement('a');
                deleteLink.textContent = 'Delete';
                deleteLink.className = 'delete-link';

                deleteLink.onclick = function (event) {
                    event.preventDefault();
                    console.log('Delete link clicked for seed:', seed.name);
                    if (confirm('Are you sure you want to delete this seed?')) {
                        fetch(`/seeds/seeds/${seed.id}/delete/`, {
                                method: 'DELETE',
                                headers: {
                                    'X-CSRFToken': getCookie('csrftoken'),
                                },
                            })
                            .then(response => {
                                if (response.ok) {
                                    console.log('Seed deleted successfully:', seed.id);
                                    seedListContainer.removeChild(listItem);
                                    showMessageAdmin('Seed deleted successfully.');
                                } else {
                                    console.error('Failed to delete seed:', seed.id);
                                    showMessageAdmin('Failed to delete seed.');
                                }
                            })
                            .catch(error => {
                                console.error('Error deleting seed:', error);
                                showMessageAdmin('An error occurred while deleting the seed.');
                            });
                    }
                };

                // Append elements to the list item
                listItem.appendChild(seedName);
                listItem.appendChild(editLink);
                listItem.appendChild(deleteLink);

                // Append the list item to the container
                seedListContainer.appendChild(listItem);
                console.log('Seed item appended for:', seed.name);
            });
        } else {
            console.warn('Data.success is false. Seeds could not be loaded.');
            const errorItem = document.createElement('li');
            errorItem.textContent = 'Failed to load seeds.';
            seedListContainer.appendChild(errorItem);
        }
    })
    .catch(error => {
        console.error('Error fetching seeds:', error);
    });

    function openEditSeedModal(seed) {
        document.getElementById('edit-seed-id').value = seed.id; // Set the ID for the hidden field
        document.getElementById('edit-seed-name').value = seed.name;
        document.getElementById('edit-seed-scientific-name').value = seed.scientific_name;
        document.getElementById('edit-seed-description').value = seed.description;
        document.getElementById('edit-seed-price').value = seed.price;
        document.getElementById('edit-seed-discount').value = seed.discount;
        document.getElementById('edit-planting_months_from').value = seed.planting_months_from;
        document.getElementById('edit-planting_months_to').value = seed.planting_months_to;
        document.getElementById('edit-flowering_months_from').value = seed.flowering_months_from;
        document.getElementById('edit-flowering_months_to').value = seed.flowering_months_to;
        document.getElementById('edit-height_from').value = Math.floor(seed.height_from);
        document.getElementById('edit-height_to').value = Math.floor(seed.height_to);
        document.getElementById('edit-sun_preference').value = seed.sun_preference;
        document.getElementById('edit-in-stock').checked = seed.is_in_stock;

        // Set the action URL for the form dynamically
        const editForm = document.getElementById('edit-seed-form');
        editForm.action = `/seeds/seeds/${seed.id}/edit/`; // Update with correct edit URL

        // Show the modal
        document.getElementById('editSeedModal').style.display = 'block';
    }

    // Add an event listener for form submission
    document.getElementById('edit-seed-form').addEventListener('submit', function (event) {
        event.preventDefault(); // Prevent the default form submission

        const formData = new FormData(this); // Create FormData object

        fetch(this.action, {
                method: 'POST', // or 'PUT' based on your backend
                body: formData,
                headers: {
                    'X-CSRFToken': getCookie('csrftoken'), // CSRF protection
                },
            })
            .then(response => {
                if (response.ok) {
                    showMessageAdmin('Seed updated successfully.'); // Show success message
                    closeEditSeedModal(); // Close the modal after successful update
                    // Optionally, refresh the seed list or update the UI accordingly here
                } else {
                    showMessageAdmin('Failed to update seed.'); // Show error message
                }
            })
            .catch(error => {
                console.error('Error updating seed:', error);
                showMessageAdmin('An error occurred while updating the seed.');
            });
    });

    // Function to close the edit seed modal
    function closeEditSeedModal() {
        document.getElementById('editSeedModal').style.display = 'none';
    }

    // Add event listener to the close button
    document.querySelector('.edit-seed-modal-close').addEventListener('click', closeEditSeedModal);

    // Optional: Close the modal when clicking outside of it
    window.onclick = function (event) {
        const modal = document.getElementById('editSeedModal');
        if (event.target === modal) {
            closeEditSeedModal();
        }
    }
    // Function to get CSRF token for AJAX requests
    function getCookie(name) {
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
});


document.getElementById('login-form').addEventListener('submit', async (event) => {
    event.preventDefault();
     const modalMessage = document.getElementById('modal-message');
     const modalIcon = document.querySelector('#login-modal img');
     showModal();
     modalMessage.textContent = 'Attempting to log in...';  // Set modal messag
     

    const csrfToken = getCookie('csrftoken');
    if (!csrfToken) {
        console.error('CSRF token is missing!');
        return;
    }

    try {
        const formData = new FormData(event.target);

        const response = await fetch('/custom_accounts/login/', {
            method: 'POST',
            headers: {
                'X-CSRFToken': csrfToken,
                'X-Requested-With': 'XMLHttpRequest' 
            },
            body: formData,
            credentials: 'include', 
        });

        if (response.headers.get('Content-Type').includes('application/json')) {
            const result = await response.json();

            if (result.success) {
                modalMessage.textContent = 'You are logged in!';
                modalIcon.src = modalIcon.getAttribute('data-success-url');

                hideModal();
                window.location.replace(result.redirect);
          
                
            } else {
              

                hideModal();
                
                // Clear any previous error messages
                const errorContainer = document.getElementById('error-messages');
                errorContainer.innerHTML = '';  // Clear old errors

                // Display new error messages
                if (result.errors && typeof result.errors === 'object') {
                    for (let field in result.errors) {
                        const errorMessage = result.errors[field];
                        const errorItem = document.createElement('p');
                        errorItem.textContent = `${errorMessage}`;
                        errorItem.style.color = 'red'; // Style for errors
                        errorContainer.appendChild(errorItem);
                    }
                } else {
                    const errorItem = document.createElement('p');
                    errorItem.textContent = 'An unknown error occurred during login.';
                    errorItem.style.color = 'red';
                    errorContainer.appendChild(errorItem);
                }
            }
        } else {
            // Handle unexpected response format (HTML, typically an error page)
            console.error('Unexpected response format:', response.status);
            const text = await response.text(); 
            console.error('Response text:', text);

            // Display a general error message
            const errorContainer = document.getElementById('error-messages');
            errorContainer.innerHTML = '';  // Clear old errors
            const errorItem = document.createElement('p');
            errorItem.textContent = 'An error occurred during login. Please try again later.';
            errorItem.style.color = 'red';
            errorContainer.appendChild(errorItem);
        }
    } catch (error) {
        console.error('Network error during login:', error); // Handle network-related issues

        // Display a network error message
        const errorContainer = document.getElementById('error-messages');
        errorContainer.innerHTML = '';  // Clear old errors
        const errorItem = document.createElement('p');
        errorItem.textContent = 'A network error occurred. Please check your connection and try again.';
        errorItem.style.color = 'red';
        errorContainer.appendChild(errorItem);
    }
});





function toggleCartButtonVisibility() {
    const cartData = JSON.parse(localStorage.getItem('cart'));
    console.log('Cart data retrieved:', cartData);

    // Get references to the cart and checkout buttons
    const cartButton = document.getElementById('cart-button');
    const checkoutBtn = document.getElementById('go-to-checkout-button');

    if (cartData && Array.isArray(cartData.items) && cartData.items.length > 0) {

        if (cartButton) {
            cartButton.style.display = 'block'; 
        }

        if (checkoutBtn) {
            checkoutBtn.style.display = 'block'; 
        }
    } else {

        if (cartButton) {
            cartButton.style.display = 'none'; 
        }

        if (checkoutBtn) {
            checkoutBtn.style.display = 'none';
        }
    }

}

document.addEventListener('DOMContentLoaded', function () {
    
    toggleCartButtonVisibility();



});

document.addEventListener('DOMContentLoaded', () => {
    const viewCartButton = document.getElementById('cart-button');
    

    if (viewCartButton) {
        viewCartButton.addEventListener('click', () => {
            window.location.href = '/cart/';
        });
    }
});

document.getElementById('logout-button').addEventListener('click', () => {
 
    localStorage.removeItem('userId');
    localStorage.removeItem('cart');
    localStorage.setItem('cartTotal', '0.00');
});





export function displayConversationsFromLocalStorage() {
    const storedConversations = localStorage.getItem('userConversations');

    if (!storedConversations) {
        console.warn('No conversations found in local storage.');
        return;
    }

    let conversations;
    try {
        conversations = JSON.parse(storedConversations);
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
    // Add a close button to chat-container
    const closeButton = document.createElement('button');
    closeButton.classList.add('btn', 'close-conversations-button');
    closeButton.innerHTML = 'X'; // Add an 'X' or any close icon you prefer
    chatContainer.appendChild(closeButton);

    // Add event listener to close button to hide the chat-container
    closeButton.addEventListener('click', () => {
        chatContainer.style.display = 'none';
    });

    if (conversations.length === 0) {
        chatContainer.innerHTML = '<p>No conversations found.</p>';
        return;
    }
    // Sort conversations: unseen messages first, then by start time (latest first)
    conversations.sort((a, b) => {
        // If 'a' has unseen messages and 'b' does not, 'a' comes first
        if (a.unseenMessagesCount > 0 && b.unseenMessagesCount === 0) return -1;
        if (a.unseenMessagesCount === 0 && b.unseenMessagesCount > 0) return 1;

        // If both have the same unseen status, sort by start time (latest first)
        return new Date(b.started_at) - new Date(a.started_at);
    });

    conversations.forEach((conversation) => {
        const conversationDiv = document.createElement('div');
        conversationDiv.className = 'conversation';
        conversationDiv.style.cursor = 'pointer';
        conversationDiv.style.marginBottom = '10px';

        if (conversation.unseenMessagesCount > 0) {
            conversationDiv.style.backgroundColor = 'red'; // Set background color to red if there are unseen messages
        }

        conversationDiv.innerHTML = `
            <span>Conversation with </span> <strong>${conversation.user}</strong><br>
            <span>Started At:</span> <strong> ${new Date(conversation.started_at).toLocaleString()}</strong>
        `;

        conversationDiv.addEventListener('click', async () => {
            showLoadingAnimation(); 
            conversationDiv.style.backgroundColor = 'transparent';

            // Gather the IDs of all unseen messages in this conversation
            if (Array.isArray(conversation.unseenMessages)) {
                const unseenMessageIds = conversation.unseenMessages.map(message => message.id);

                // Call the updateMessageStatus function to mark messages as seen
                if (unseenMessageIds.length > 0) {
                    await updateMessageStatus(unseenMessageIds, true); // Mark all unseen messages as seen
                }
            } else {
                console.warn('No unseen messages found or unseenMessages is not an array');
            }
            chatContainer.style.display = 'none'
            // Load conversation messages
            await loadConversationMessages(conversation.id, loggedInUsername);
            hideLoadingAnimation(); 
           
            await fetchMessageCounts();
        });
        chatContainer.appendChild(conversationDiv);
    });

}
async function loadConversationMessages(conversationId, loggedInUsername) {
    try {
        const response = await fetch(`/syncmanager/api/get_conversation_messages/${conversationId}/`);

        if (!response.ok) throw new Error('Network response was not ok');

        const responseData = await response.json();

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
                    <button id="send-message-button" class="btn">Send</button>
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
            const formatMessageDate = (date) => {
                const options = {
                    day: '2-digit',
                    month: 'short'
                }; // Day and month in short form (e.g., "05 Oct")
                const dateString = date.toLocaleDateString(undefined, options);
                const timeString = date.toLocaleTimeString(undefined, {
                    hour: '2-digit',
                    minute: '2-digit'
                }); // Time in HH:MM format
                return `${dateString}, ${timeString}`; // Combine date and time
            };

            messageDiv.innerHTML = `
                                    <div class="message-header">
                                        <strong>${message.sender}</strong>
                                        
                                    </div>
                                    <div class="message-body">
                                        <p>${message.content}</p>
                                    </div>

                                    <div class="message-footer">
                                        
                                        <span class="message-time">${formatMessageDate(new Date())}</span>
                                    </div>
            `;
            modalMessageList.appendChild(messageDiv);
        });

        messageModal.style.display = 'block';
        // Delay the scroll to allow the messages to render
        setTimeout(() => {
            // Use requestAnimationFrame to ensure DOM updates
            requestAnimationFrame(() => {
                modalMessageList.scrollTop = modalMessageList.scrollHeight; // Scroll to bottom
            });
        }, 100);
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
        const data = await sendMessage(conversationId, messageContent);


        // Check if data is defined and has a success property
        if (data && data.success) {
            const modalMessageList = document.getElementById('modal-message-list');
            const newMessageDiv = document.createElement('div');
            newMessageDiv.className = `chat-message message-right message-right`; 
            const formatMessageDate = (date) => {
                const options = {
                    day: '2-digit',
                    month: 'short'
                }; 
                const dateString = date.toLocaleDateString(undefined, options);
                const timeString = date.toLocaleTimeString(undefined, {
                    hour: '2-digit',
                    minute: '2-digit'
                }); 
                return `${dateString}, ${timeString}`; 
            };

            newMessageDiv.innerHTML = `
                <div class="message-header">
                    <strong>${loggedInUsername}</strong>
                   
                </div>
                <div class="message-body">
                    <p>${messageContent}</p>
                </div>
                <div class="message-footer">
                   
                    <span class="message-time">${formatMessageDate(new Date())}</span>
                </div>
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
        
        const messageDiv = document.createElement('div');
        const messageClass = message.sender === loggedInUsername ? 'message-right' : 'message-left';
        messageDiv.className = `chat-message ${messageClass}`;
        messageDiv.innerHTML = `
            <strong>${message.sender}:</strong> ${message.content}<br>
            <em>${new Date(message.sent_at).toLocaleString()}</em>
        `;

        modalMessageList.appendChild(messageDiv);
    });


    messageModal.style.display = 'block'; // Show the modal
    requestAnimationFrame(() => {
        modalMessageList.scrollTop = modalMessageList.scrollHeight; // Scroll to bottom after rendering messages
    });
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
    sendButton.onclick = async () => {
        if (conversationId) {
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
    const result = await checkIfSuperUser();

    if (result === null) {
        // Handle failure, e.g., by logging or showing an error message
        console.error('Failed to fetch user status.');
        return;
    }

    const {
        isSuperUser,
        isAuthenticated
    } = result;

    const notificationArea = document.getElementById('notification-area');
    const adminIcon = document.getElementById('admin-message-icon');
    const messageIcon = document.getElementById('messagesIcon');

    if (!isAuthenticated) {
        notificationArea.style.display = 'none';
    } else {
        notificationArea.style.display = 'block';

        if (isSuperUser) {
            adminIcon.style.display = 'block';
            messageIcon.style.display = 'none';
        } else {
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
        }
    } catch (error) {
        console.error('Network error:', error);
    }
}

function createLoadingOverlay() {
    loadingOverlay = document.createElement('div');
    loadingOverlay.id = 'loading-overlay';
    loadingOverlay.style.position = 'fixed'; // Fix position to overlay the entire screen
    loadingOverlay.style.top = '50%'; // Center vertically
    loadingOverlay.style.left = '50%'; // Center horizontally
    loadingOverlay.style.width = '300px'; // Set width to 300px
    loadingOverlay.style.height = '200px'; // Set height to 200px
    loadingOverlay.style.backgroundColor = 'rgba(0, 0, 0, 0.9)'; // Semi-transparent background
    loadingOverlay.style.display = 'flex'; // Use flexbox to center content
    loadingOverlay.style.justifyContent = 'center'; // Center content horizontally
    loadingOverlay.style.alignItems = 'center'; // Center content vertically
    loadingOverlay.style.zIndex = '999999999999999999999'; // Ensure it appears on top of other elements
    loadingOverlay.style.transform = 'translate(-50%, -50%)'; // Center the overlay

    // Create the loading text
    loadingText = document.createElement('div');
    loadingText.id = 'loading-text';
    loadingText.style.color = 'white'; // Set text color to white
    loadingText.style.fontSize = '24px'; // Set font size
    loadingText.style.textTransform = 'uppercase'; // Make text uppercase
    loadingText.style.textAlign = 'center'; // Center the text
    loadingText.style.margin = '0'; // Remove default margin

    // Append loading text to the overlay
    loadingOverlay.appendChild(loadingText);

    // Append the overlay to the body
    document.body.appendChild(loadingOverlay);
}


function showLoadingAnimation() {
    createLoadingOverlay();

    const text = "Loading";
    let index = 0;

    const intervalId = setInterval(() => {
        loadingText.textContent = text.slice(0, index) + '.'.repeat(index % 4);
        index++;

        if (index > text.length) {
            index = text.length; // Limit to the length of the text
        }

        // Stop the animation after the full text is displayed with dots
        if (index === text.length && loadingText.textContent.endsWith('...')) {
            clearInterval(intervalId);
        }
    }, 400);
}

function hideLoadingAnimation() {
   
    if (loadingOverlay) {
        loadingOverlay = null; 
        
    } else {
        console.log("No loading overlay found to remove.");
    }
}


