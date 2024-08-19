document.addEventListener('DOMContentLoaded', function() {
    const searchInput = document.getElementById('searchInput');
    const searchButton = document.getElementById('searchButton');

    // Clear input field on page load
    searchInput.value = '';

    // Toggle button visibility on input click
    searchInput.addEventListener('focus', function() {
        searchButton.style.display = 'block';
        searchInput.placeholder = "Search seeds..."; // Show placeholder on focus
    });

    searchInput.addEventListener('blur', function() {
        if (searchInput.value === '') {
            searchButton.style.display = 'none';
            searchInput.placeholder = ''; // Hide placeholder on blur
        }
    });

    // Clear input field when search button is clicked
    searchButton.addEventListener('click', function() {
        searchInput.value = '';
    });
});
