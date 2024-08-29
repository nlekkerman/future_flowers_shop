document.getElementById('messageForm').addEventListener('submit', function(event) {
    event.preventDefault();  // Prevent the default form submission

    var form = event.target;
    var formData = new FormData(form);
    
    // Get the input field value
    var messageContent = formData.get('content');  // 'content' should match the name attribute of your form input
    console.log('Message content:', messageContent);

    // Send the form data using fetch
    fetch(form.action, {
        method: 'POST',
        body: formData,
        headers: {
            'X-Requested-With': 'XMLHttpRequest',
            'X-CSRFToken': formData.get('csrfmiddlewaretoken')
        }
    })
    .then(response => response.json())
    .then(data => {
        console.log('Message sent:', data);
        // Optionally, update the messages section here
        // For simplicity, you can redirect to the same page
         // Clear the form fields
         form.reset();

        window.location.reload();
    })
    .catch(error => console.error('Error:', error));
});
