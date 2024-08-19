document.addEventListener('DOMContentLoaded', function () {
    // Toggle filter buttons visibility on small screens
    const filterToggle = document.getElementById('filterToggle');
    const filterButtons = document.querySelector('.filter-buttons');

    filterToggle.addEventListener('click', function () {
        if (filterButtons.style.display === 'none' || filterButtons.style.display === '') {
            filterButtons.style.display = 'flex';
        } else {
            filterButtons.style.display = 'none';
        }
    });

    // Expand search input and show button when input is focused
    const searchInput = document.getElementById('searchInput');
    const searchButton = document.getElementById('searchButton');

    searchInput.addEventListener('focus', function () {
        searchInput.style.width = '150px'; // Expand input field
        searchInput.style.backgroundColor = '#fff'; // Change background color
        searchInput.style.border = '1px solid #ccc'; // Add border
        searchButton.style.display = 'inline-block'; // Show search button
    });

    searchInput.addEventListener('blur', function () {
        if (searchInput.value === '') {
            searchInput.style.width = '30px'; // Shrink input field if no text
            searchInput.style.backgroundColor = 'transparent'; // Reset background color
            searchInput.style.border = 'none'; // Remove border
            searchButton.style.display = 'none'; // Hide search button
        }
    });
});

