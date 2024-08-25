document.addEventListener('DOMContentLoaded', function() {
    const reviewForm = document.getElementById('review-form');
    const ratingInputs = reviewForm.querySelectorAll('input[name="rating"]');
    const ratingLabels = reviewForm.querySelectorAll('label.fas.fa-heart');

    function updateHearts(selectedIndex) {
        ratingLabels.forEach((label, labelIndex) => {
            // Ensure correct index comparison
            if (labelIndex < selectedIndex) {
                label.classList.add('active');
            } else {
                label.classList.remove('active');
            }
        });
    }

    ratingInputs.forEach((input, index) => {
        input.addEventListener('change', () => {
            const selectedIndex = Array.from(ratingInputs).indexOf(input) + 1; // Convert zero-based index to one-based
            console.log(`Selected Index on Change: ${selectedIndex}`);
            updateHearts(selectedIndex);
        });
    });

    reviewForm.addEventListener('submit', function(event) {
        const selectedRating = reviewForm.querySelector('input[name="rating"]:checked');
        if (!selectedRating) {
            event.preventDefault();
            alert('Please select a rating.');
        }
    });

    // Initial display of hearts based on the default selected rating
    const defaultRating = reviewForm.querySelector('input[name="rating"]:checked');
    if (defaultRating) {
        const defaultIndex = Array.from(ratingInputs).indexOf(defaultRating) + 1;
        console.log(`Selected Index on Load: ${defaultIndex}`);
        updateHearts(defaultIndex);
    }
});
document.addEventListener('DOMContentLoaded', function() {
    const editReviewForm = document.getElementById('edit-review-form');
    const ratingInputs = editReviewForm.querySelectorAll('input[name="rating"]');
    const ratingLabels = editReviewForm.querySelectorAll('label.fas.fa-heart');

    function updateHearts(selectedIndex) {
        ratingLabels.forEach((label, labelIndex) => {
            if (labelIndex < selectedIndex) {
                label.classList.add('active'); // Make the heart golden
            } else {
                label.classList.remove('active'); // Remove golden color
            }
        });
    }

    ratingInputs.forEach((input, index) => {
        input.addEventListener('change', () => {
            const selectedIndex = Array.from(ratingInputs).indexOf(input) + 1; // Convert zero-based index to one-based
            console.log(`Selected Index on Change: ${selectedIndex}`);
            updateHearts(selectedIndex);
        });
    });

    editReviewForm.addEventListener('submit', function(event) {
        const selectedRating = editReviewForm.querySelector('input[name="rating"]:checked');
        if (!selectedRating) {
            event.preventDefault();
            alert('Please select a rating.');
        }
    });

    // Initial display of hearts based on the default selected rating
    const defaultRating = editReviewForm.querySelector('input[name="rating"]:checked');
    if (defaultRating) {
        const defaultIndex = Array.from(ratingInputs).indexOf(defaultRating) + 1;
        console.log(`Selected Index on Load: ${defaultIndex}`);
        updateHearts(defaultIndex);
    } else {
        // If no default rating is selected, ensure hearts are reset
        updateHearts(0); // No hearts should be active
    }
});
