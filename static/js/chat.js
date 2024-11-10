document.addEventListener('DOMContentLoaded', function () {
    const chatIcon = document.getElementById('chat-icon');
    const chatWindow = document.getElementById('chat-window');
    const closeChatButton = document.getElementById('close-chat');
    const messageInput = document.getElementById('message-input');
    const sendMessageButton = document.getElementById('send-message');

    let currentConversationId = null;

    chatIcon.addEventListener('click', function () {
      
        if (chatWindow.style.display === 'none' || chatWindow.style.display === '') {
            console.log('Opening chat window.');
            chatWindow.style.display = 'flex';
            startOrLoadConversation();
        } else {
            chatWindow.style.display = 'none';
        }
    });

    closeChatButton.addEventListener('click', function () {
        chatWindow.style.display = 'none';
    });

    sendMessageButton.addEventListener('click', function () {
        const text = messageInput.value;
        if (text.trim() !== '') {
            if (currentConversationId) {
                sendMessage(text);
                messageInput.value = '';
            } else {
                console.error('No conversation ID available.');
            }
        } else {
            console.log('Message text is empty.');
        }
    });

    function startOrLoadConversation() {
        console.log('Fetching conversation data.');
    
        const userId = 1; 
        const superuserId = 1; 
    
    
        fetch('/chat/start-or-load-conversation/', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRFToken': getCookie('csrftoken')
            },
            body: JSON.stringify({
                user_id: userId,
                superuser_id: superuserId
            })
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok.');
            }
            return response.json();
        })
        .then(data => {
            if (data.conversation_id) {
                currentConversationId = data.conversation_id; 
                loadMessages(currentConversationId);
            } else {
                console.error('Failed to start or load conversation.');
            }
        })
        .catch(error => {
            console.error('Error starting or loading conversation:', error);
        });
    }
    function loadMessages(conversationId) {
        fetch(`/chat/get-messages/${conversationId}/`, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRFToken': getCookie('csrftoken')
            }
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok.');
            }
            return response.json();
        })
        .then(data => {
            const messagesContainer = document.getElementById('messages');
            messagesContainer.innerHTML = ''; // Clear existing messages
            data.messages.forEach(message => {
                const messageElement = document.createElement('div');
                messageElement.textContent = `${message.sender}: ${message.text}`;
                messagesContainer.appendChild(messageElement);
            });
        })
        .catch(error => {
            console.error('Error loading messages:', error);
        });
    }

    function sendMessage(text) {
        fetch('/chat/send-message/', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRFToken': getCookie('csrftoken')
            },
            body: JSON.stringify({
                conversation_id: currentConversationId, // Use the stored conversation ID
                text: text
            })
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok.');
            }
            return response.json();
        })
        .then(data => {
            loadMessages(currentConversationId);  // Reload messages after sending
        })
        .catch(error => {
            console.error('Error sending message:', error);
        });
    }

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
