document.addEventListener('DOMContentLoaded', function() {
    // Function to handle rating interactions
    function setupRatingInteraction(formId) {
        const form = document.getElementById(formId);
        if (!form) return; // Exit if the form is not found

        const ratingInputs = form.querySelectorAll('input[name="rating"]');
        const ratingLabels = form.querySelectorAll('label.fas.fa-heart');

        function updateHearts(selectedIndex) {
            ratingLabels.forEach((label, index) => {
                if (index < selectedIndex) {
                    label.classList.add('active');
                } else {
                    label.classList.remove('active');
                }
            });
        }

        ratingInputs.forEach((input, index) => {
            input.addEventListener('change', () => {
                const selectedIndex = index + 1; // Convert zero-based index to one-based
                updateHearts(selectedIndex);
            });
        });

        // Initial display of hearts based on the default selected rating
        const defaultRating = form.querySelector('input[name="rating"]:checked');
        if (defaultRating) {
            const defaultIndex = Array.from(ratingInputs).indexOf(defaultRating) + 1;
            updateHearts(defaultIndex);
        }
    }

    // Setup for the review form
    setupRatingInteraction('review-form');

    // Setup for the edit review form
    setupRatingInteraction('edit-review-form');

    // Toggle visibility of rating and review edit forms
    const editRatingBtn = document.getElementById('edit-rating-btn');
    const editReviewBtn = document.getElementById('edit-review-btn');
    const ratingEditForm = document.getElementById('rating-edit-form');
    const reviewEditForm = document.getElementById('review-edit-form');
    const updateReviewBtn = document.getElementById('update-review-btn');

    // Toggle rating edit form
    if (editRatingBtn) {
        editRatingBtn.addEventListener('click', function() {
            const isVisible = ratingEditForm.style.display === 'block';
            ratingEditForm.style.display = isVisible ? 'none' : 'block';
            reviewEditForm.style.display = 'none'; // Hide review edit form
            updateReviewBtn.style.display = isVisible ? 'none' : 'block'; // Show update button when editing
        });
    }

    // Toggle review edit form
    if (editReviewBtn) {
        editReviewBtn.addEventListener('click', function() {
            const isVisible = reviewEditForm.style.display === 'block';
            reviewEditForm.style.display = isVisible ? 'none' : 'block';
            ratingEditForm.style.display = 'none'; // Hide rating edit form
            updateReviewBtn.style.display = isVisible ? 'none' : 'block'; // Show update button when editing
        });
    }

    // Handle form submission for the review
    const updateReviewForm = document.getElementById('update-review-form');
    if (updateReviewForm) {
        updateReviewForm.addEventListener('submit', function(event) {
            const selectedRating = updateReviewForm.querySelector('input[name="rating"]:checked');
            if (!selectedRating) {
                event.preventDefault();
                alert('Please select a rating.');
            }
        });
    }
});


document.addEventListener('DOMContentLoaded', function() {
    function toggleBadgeVisibility() {
        // Get all review elements
        var reviewElements = document.querySelectorAll('.review');

        // Iterate over each review element
        reviewElements.forEach(function(reviewElement) {
            // Retrieve the data attributes
            var createdAt = reviewElement.getAttribute('data-original-created-at');
            var updatedAt = reviewElement.getAttribute('data-original-updated-at');
            
            // Log the values to the console for debugging
            console.log('Created At:', createdAt);
            console.log('Updated At:', updatedAt);

            // Get the badge-edited element within the current review
            var badgeEdited = reviewElement.querySelector('.badge-edited');
            
            // Log the badge element for debugging
            console.log('Badge Edited Element:', badgeEdited);

            if (badgeEdited) {
                // Compare the values and toggle visibility
                if (createdAt !== updatedAt) {
                    badgeEdited.style.display = 'block'; // Show if not equal
                } else {
                    badgeEdited.style.display = 'none';  // Hide if equal
                }
            }
        });
    }

    // Call the function to apply the logic
    toggleBadgeVisibility();
});
