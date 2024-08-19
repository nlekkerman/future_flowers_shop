// Function to initialize and render the Google Sign-In button
function renderGoogleSignInButton() {
    gapi.signin2.render('g-signin2', {
        'scope': 'profile email',
        'width': 240,
        'height': 50,
        'longtitle': true,
        'theme': 'dark',
        'onsuccess': onSignIn,
        'onfailure': onFailure
    });
}

// Function called when the user successfully signs in
function onSignIn(googleUser) {
    // Get the Google user's ID token
    var id_token = googleUser.getAuthResponse().id_token;

    // Send the ID token to your server for verification and user authentication
    fetch('/your-server-endpoint', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-CSRFToken': getCsrfToken() // Function to get CSRF token
        },
        body: JSON.stringify({ id_token: id_token })
    }).then(response => response.json())
      .then(data => {
        // Handle server response
        console.log('Success:', data);
        // Redirect or update UI based on server response
      })
      .catch((error) => {
        console.error('Error:', error);
      });
}

// Function called when the sign-in fails
function onFailure(error) {
    console.error('Sign-in error:', error);
}

// Function to get CSRF token from the document
function getCsrfToken() {
    var cookieValue = null;
    if (document.cookie && document.cookie !== '') {
        var cookies = document.cookie.split(';');
        for (var i = 0; i < cookies.length; i++) {
            var cookie = cookies[i].trim();
            // Check if this cookie string begins with the name of the CSRF token
            if (cookie.substring(0, 10) === 'csrftoken=') {
                cookieValue = decodeURIComponent(cookie.substring(10));
                break;
            }
        }
    }
    return cookieValue;
}

// Load the Google API and initialize the sign-in button when the DOM is fully loaded
document.addEventListener('DOMContentLoaded', function() {
    gapi.load('auth2', function() {
        gapi.auth2.init().then(renderGoogleSignInButton);
    });
});
