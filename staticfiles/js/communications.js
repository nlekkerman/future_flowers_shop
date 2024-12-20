
    document.addEventListener('DOMContentLoaded', function() {
        function handleFormSubmit(formId, conversationId) {
            const form = document.getElementById(formId);
            if (!form) return;
    
            form.addEventListener('submit', function(event) {
                event.preventDefault();
    
                const formData = new FormData(form);
                fetch(form.action, {
                    method: 'POST',
                    body: formData,
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest',
                        'X-CSRFToken': form.querySelector('[name="csrfmiddlewaretoken"]').value
                    }
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        const messagesContainer = document.querySelector('#chat-messages');
                        const messageElement = document.createElement('div');
                        messageElement.className = 'message';
                        messageElement.innerHTML = `<p>${data.message}</p>`;
                        messagesContainer.appendChild(messageElement);
                        form.reset();
                    } else {
                        console.error('Error:', data.errors);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                });
            });
        }
    
    
    
        handleFormSubmit('chat-message-form', conversationId);
        handleChatBotChoice();
    });
    
