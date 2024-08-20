document.addEventListener('DOMContentLoaded', function () {
    const searchForm = document.getElementById('search-form');
    const searchInput = document.getElementById('searchInput');

    console.log('Search form:', searchForm);
    console.log('Search input:', searchInput);

    searchForm.addEventListener('submit', function(event) {
        const queryValue = searchInput.value;
        console.log('Search query:', queryValue);  // Debugging line

        if (!queryValue) {
            event.preventDefault();  // Prevent form submission if value is not set correctly
            alert('Search input is empty!');
        }
    });
});

document.addEventListener('DOMContentLoaded', function() {
    // Handle close button clicks
    const closeButtons = document.querySelectorAll('.close-button-container');
    closeButtons.forEach(function(button) {
        button.addEventListener('click', function() {
            const message = this.closest('.message-container');
            if (message) {
                message.style.display = 'none'; // Hide the message
            }
        });
    });
    

});
