
    document.addEventListener('DOMContentLoaded', function() {
        // Get elements
        const chatBotOptions = document.getElementById('chat-bot-options');
        const chatBotSuboptions = document.getElementById('chat-bot-suboptions');
        const messageForm = document.getElementById('message-form');

        // Handle chat bot suboption clicks
        chatBotSuboptions.addEventListener('click', function(event) {
            if (event.target.name === 'subchoice' && event.target.value === '1.2' || event.target.value === '2.2') {
                chatBotOptions.classList.add('hidden');
                chatBotSuboptions.classList.add('hidden');
                messageForm.classList.remove('hidden');
            }
        });
    });
