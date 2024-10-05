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
        fetchCartData();
        await fetchAndStoreSeeds();
        const chatContainer = document.getElementById('chat-container');
        const messagesIcon = document.getElementById('messagesIcon');
        const adminMessagesIcon = document.getElementById('admin-message-icon');



        const toggleChatContainerVisibility = () => {
            // Add condition to check if userId is 1
            if (userId !== 1) {
                return; // Do nothing if userId is not 1
            }

            if (chatContainer.style.display === "block") {
                console.log("CHAT TOGGLE HIDDEN");
                chatContainer.style.display = "none"; // Hide the chat container
            } else {
                chatContainer.style.display = "block"; // Show the chat container
                console.log("CHAT TOGGLE VISIBLE");
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

document.addEventListener('DOMContentLoaded', function () {
    updateCartTotalUILogin(); // Update cart total when the page loads
    // Run the function when the page loads
    // Get the elements by their ID



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
    // Set cart total to 0 in localStorage
    localStorage.setItem('cartTotal', '0.00'); // Store total as a string



    console.log('Cart cleared and total set to $0.00 after logout.');

});

document.getElementById('login-button').addEventListener('click', async () => {
    console.log('Login button clicked. Fetching cart data...');

    try {
        // Call fetchCartData() to retrieve the cart data after login
        await fetchCartData();
        updateCartTotalUILogin()
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
    // Add a close button to chat-container
    const closeButton = document.createElement('button');
    closeButton.classList.add('btn', 'close-conversations-button');
    closeButton.innerHTML = 'X'; // Add an 'X' or any close icon you prefer
    chatContainer.appendChild(closeButton);

    // Add event listener to close button to hide the chat-container
    closeButton.addEventListener('click', () => {
        console.info('Close button clicked. Hiding chat container.');
        chatContainer.style.display = 'none';
    });

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

        // Check if the conversation has unseen messages
        if (conversation.unseenMessagesCount > 0) {
            conversationDiv.style.backgroundColor = 'red'; // Set background color to red if there are unseen messages
        }

        conversationDiv.innerHTML = `
            <span>Conversation with </span> <strong>${conversation.user}</strong><br>
            <span>Started At:</span> <strong> ${new Date(conversation.started_at).toLocaleString()}</strong>
        `;

        conversationDiv.addEventListener('click', async () => {
            showLoadingAnimation(); // Show loading animation
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
            hideLoadingAnimation(); // Hide loading animation after loading messages
            // Fetch updated message counts
            await fetchMessageCounts();
        });
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
                const options = { day: '2-digit', month: 'short' }; // Day and month in short form (e.g., "05 Oct")
                const dateString = date.toLocaleDateString(undefined, options);
                const timeString = date.toLocaleTimeString(undefined, { hour: '2-digit', minute: '2-digit' }); // Time in HH:MM format
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
            console.log('Username AHAHAHAHAHAHA before sending message:', loggedInUsername); // Debugging
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
            newMessageDiv.className = `chat-message message-right message-right`; // Assuming sent messages go to the right
            const formatMessageDate = (date) => {
                const options = { day: '2-digit', month: 'short' }; // Day and month in short form (e.g., "05 Oct")
                const dateString = date.toLocaleDateString(undefined, options);
                const timeString = date.toLocaleTimeString(undefined, { hour: '2-digit', minute: '2-digit' }); // Time in HH:MM format
                return `${dateString}, ${timeString}`; // Combine date and time
            };
            
            // Example usage for creating a new message div
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

function createLoadingOverlay() {
    console.log("Creating loading overlay..."); // Log when creating overlay
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
    console.log("Loading overlay created and added to the body.");
}


function showLoadingAnimation() {
    console.log("Showing loading animation..."); // Log when showing animation
    createLoadingOverlay(); // Ensure the overlay is created

    const text = "Loading";
    let index = 0;

    const intervalId = setInterval(() => {
        loadingText.textContent = text.slice(0, index) + '.'.repeat(index % 4);
        console.log(`Loading text updated: ${loadingText.textContent}`); // Log loading text update
        index++;

        if (index > text.length) {
            index = text.length; // Limit to the length of the text
        }

        // Stop the animation after the full text is displayed with dots
        if (index === text.length && loadingText.textContent.endsWith('...')) {
            clearInterval(intervalId);
            console.log("Loading animation completed."); // Log when animation is completed
        }
    }, 400); // Change this value to speed up or slow down the animation
}

function hideLoadingAnimation() {
    console.log("Hiding loading animation..."); // Log when hiding animation
    if (loadingOverlay) {
        document.body.removeChild(loadingOverlay); // Remove the overlay from the body
        loadingOverlay = null; // Reset to null
        console.log("Loading overlay removed from the body."); // Log when overlay is removed
    } else {
        console.log("No loading overlay found to remove."); // Log if overlay was not found
    }
}


document.addEventListener("DOMContentLoaded", function () {
    

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

// Function to create a new seed
  function createSeed() {
      const createSeedForm = document.getElementById('create-seed-form');
      createSeedForm.addEventListener('submit', function(event) {
          event.preventDefault(); // Prevent the default form submission

          const formData = new FormData(this); // Create FormData object

          fetch('/seeds/seeds/create/', { // Update with your actual creation URL
              method: 'POST', // Use POST for creation
              body: formData,
              headers: {
                  'X-CSRFToken': getCookie('csrftoken'), // CSRF protection
              },
          })
          .then(response => {
              if (response.ok) {
                  showMessageAdmin('Seed created successfully!'); // Show success message
                  // Optionally, refresh the seed list or clear the form
                  fetchSeeds(); // Call a function to refresh the seed list
              } else {
                  showMessageAdmin('Failed to create seed.'); // Show error message
              }
          })
          .catch(error => {
              console.error('Error creating seed:', error);
              showMessageAdmin('An error occurred while creating the seed.');
          });
      });
  }


  fetch('/seeds/api/seeds/')
      .then(response => response.json())
      .then(data => {
          const seedListContainer = document.getElementById('seed-list');
          if (!seedListContainer) {
              console.error('Element with ID "seed-list" not found in the DOM.');
              return; // Exit if the element doesn't exist
          }
          
          seedListContainer.innerHTML = ''; // Clear any existing content

          if (data.success) {
              // Loop through the seeds and create a list item for each
              // Loop through the seeds and create a list item for each
              data.seeds.forEach(seed => {
                  // Create list item
                  const listItem = document.createElement('li');
                  listItem.className = 'seed-list-item'; // Add class for styling

                  // Create a span for seed name with styling
                  const seedName = document.createElement('span');
                  seedName.className = 'seed-name'; // Add class for seed name
                  seedName.textContent = `${seed.name} (${seed.scientific_name})`;

                  // Create Edit link
                  const editLink = document.createElement('a');
                  editLink.textContent = 'Edit';
                  editLink.className = 'edit-link'; // Add class for edit link

                  // Event listener to open the modal and populate data
                  editLink.addEventListener('click', function (event) {
                      event.preventDefault(); // Prevent the default action of the link
                      openEditSeedModal(seed); // Call the function to open the modal and pass the seed data
                      
                  });

                  // Create Delete link
                  const deleteLink = document.createElement('a');
                  deleteLink.textContent = 'Delete';
                  deleteLink.className = 'delete-link'; // Add class for delete link
                  deleteLink.onclick = function (event) {
                      event.preventDefault(); // Prevent default link behavior
                      if (confirm('Are you sure you want to delete this seed?')) {
                          // Perform delete action here
                          fetch(`/seeds/seeds/${seed.id}/delete/`, {
                                  method: 'DELETE', // Assuming your delete method
                                  headers: {
                                      'X-CSRFToken': getCookie('csrftoken'), // CSRF protection
                                  },
                              })
                              .then(response => {
                                  if (response.ok) {
                                      seedListContainer.removeChild(listItem);
                                      showMessageAdmin('Seed deleted successfully.'); // Show message
                                  } else {
                                      showMessageAdmin('Failed to delete seed.'); // Show error message
                                  }
                              })
                              .catch(error => {
                                  console.error('Error deleting seed:', error);
                                  showMessageAdmin('An error occurred while deleting the seed.');

                              });
                      }
                  };

                  // Append seed name and buttons to the list item
                  listItem.appendChild(seedName);
                  listItem.appendChild(editLink);
                  listItem.appendChild(deleteLink);

                  // Append the list item to the container
                  seedListContainer.appendChild(listItem);
              });


          } else {
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
      document.getElementById('edit-seed-form').addEventListener('submit', function(event) {
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

