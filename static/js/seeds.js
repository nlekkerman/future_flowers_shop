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


document.addEventListener('DOMContentLoaded', function() {
    // Show modal when a delete button is clicked
    document.querySelectorAll('.delete-review-button').forEach(button => {
        button.addEventListener('click', function(event) {
            event.preventDefault(); // Prevent default action
            const modalId = this.getAttribute('data-modal-id'); // Get modal ID
            const modal = document.getElementById(modalId);

            if (modal) {
                modal.style.display = 'block'; // Show the modal
            } else {
                console.error(`Modal with ID ${modalId} not found.`);
            }
        });
    });

    // Hide the modal when the cancel button is clicked
    document.querySelectorAll('.red-border').forEach(button => {
        button.addEventListener('click', function() {
            const modal = this.closest('.modal');
            if (modal) {
                modal.style.display = 'none'; // Hide the modal
            }
        });
    });

    // Hide the modal if clicking outside the modal content
    window.addEventListener('click', function(event) {
        if (event.target.classList.contains('modal')) {
            event.target.style.display = 'none'; // Hide the modal
        }
    });
});
