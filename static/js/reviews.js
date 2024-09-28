import {
    fetchUserId
} from './control.js';


document.addEventListener('DOMContentLoaded', function () {


    const icon = document.getElementById('icon');
    const reviewsContainer = document.getElementById('reviews-container');
    // Create the message modal container
    const messageModal = document.createElement('div');
    messageModal.id = 'modal-overlay-background'; // Three-word ID
    messageModal.className = 'modal-overlay-background'; // Three-word class name
    messageModal.style.display = 'none';
    messageModal.style.position = 'fixed';
    messageModal.style.zIndex = '1000';
    messageModal.style.left = '0';
    messageModal.style.top = '0';
    messageModal.style.width = '100%';
    messageModal.style.height = '100%';
    messageModal.style.backgroundColor = 'rgba(0, 0, 0, 0.5)';
    messageModal.style.justifyContent = 'center';
    messageModal.style.alignItems = 'center';

    // Create the modal content box
    const modalContent = document.createElement('div');
    modalContent.className = 'modal-box-content'; // Three-word class name


    // Create the modal message paragraph
    const modalMessage = document.createElement('p');

    // Create the close button
    const closeButton = document.createElement('button');
    closeButton.className = 'button-close-modal'; // Three-word class name
    closeButton.textContent = ' <i class="fas fa-times-circle"></i> ';
    closeButton.onclick = function () {
        messageModal.style.display = 'none'; // Close the modal
    };

    // Append the message and close button to the modal content
    modalContent.appendChild(modalMessage);
    modalContent.appendChild(closeButton);

    // Append the modal content to the modal container
    messageModal.appendChild(modalContent);

    // Add the modal container to the body
    document.body.appendChild(messageModal);

    // Function to display the message modal
    function showMessageReview(message) {
        modalMessage.textContent = message; // Set the message text
        messageModal.style.display = 'flex'; // Show the modal
    }
    // Function to load reviews
    async function loadReviews() {
        console.log('Initiating review loading process...');

        // First, get the logged-in user's ID
        const currentUserID = await fetchUserId(); // Use the fetchUserId function from control.js

        if (currentUserID === null) {
            console.error('Unable to retrieve current user ID.');
            return;
        }

        // Fetch the reviews from the API
        fetch('/reviews/api/reviews/')
            .then(response => {
                console.log('Received response from the API:', response);

                // Check if the response is OK (status code 200)
                if (!response.ok) {
                    throw new Error(`Network response was not ok: ${response.status} ${response.statusText}`);
                }

                // Parse the JSON response
                return response.json();
            })
            .then(data => {
                console.log('Parsed JSON data:', data); // Log parsed data
                const reviewsContainer = document.getElementById('reviews-container');

                if (!reviewsContainer) {
                    throw new Error("reviews-container element not found");
                }

                reviewsContainer.innerHTML = ''; // Clear previous content
                // Create and add the close button at the top right corner
                const closeButton = document.createElement('button');
                closeButton.id = 'close-reviews';
                closeButton.classList.add('btn-danger', 'close-button');
                closeButton.innerHTML = `x`; // Using FontAwesome icon
                closeButton.style.position = 'absolute';
                closeButton.style.width = '30px';

                closeButton.style.right = '90px'; // Adjust to desired position
                closeButton.style.zIndex = '1000'; // Ensure it is above other elements

                // Add click event to close the reviews container
                closeButton.addEventListener('click', function () {
                    reviewsContainer.style.display = 'none'; // Hide the reviews container
                });
                reviewsContainer.appendChild(closeButton); // Add close button to container

                // Create and add the Write Review button at the top
                const writeReviewButton = document.createElement('button');
                writeReviewButton.id = 'write-review';
                writeReviewButton.classList.add('review-button'); // Adding the "btn" class
                writeReviewButton.innerHTML = ` <i class="fas fa-pencil-alt"></i>`;
                reviewsContainer.appendChild(writeReviewButton);

                // Add click event for the Write Review button
                writeReviewButton.addEventListener('click', function () {
                    openReviewModal();
                });

                // Create a Bootstrap row container for the reviews
                const rowElement = document.createElement('div');
                rowElement.classList.add('custom-review-row');
                reviewsContainer.appendChild(rowElement);
                // Create and add scroll arrows dynamically
                const scrollUp = document.createElement('button');
                scrollUp.id = 'scroll-up';
                scrollUp.classList.add('arrow');
                scrollUp.innerHTML = '&#9650;'; // Up arrow symbol
                reviewsContainer.appendChild(scrollUp);

                const scrollDown = document.createElement('button');
                scrollDown.id = 'scroll-down';
                scrollDown.classList.add('arrow');
                scrollDown.innerHTML = '&#9660;'; // Down arrow symbol
                reviewsContainer.appendChild(scrollDown);

                // Add scroll event listeners for arrows
                scrollUp.addEventListener('click', () => {
                    rowElement.scrollBy({
                        top: -100, // Scroll up by 100 pixels
                        behavior: 'smooth' // Smooth scroll
                    });
                });

                scrollDown.addEventListener('click', () => {
                    rowElement.scrollBy({
                        top: 100, // Scroll down by 100 pixels
                        behavior: 'smooth' // Smooth scroll
                    });
                });
                // Loop through the reviews and create HTML elements for each
                data.reviews.forEach(review => {
                    console.log(`Review ID: ${review.id}, Review User ID: ${review.user_id}, Current User ID: ${currentUserID}`);

                    // Create a column for each review with Bootstrap responsive classes
                    const reviewElement = document.createElement('div');
                    reviewElement.classList.add('col-12', 'col-md-6', 'col-lg-4', 'col-xl-2', 'd-flex');

                    reviewElement.innerHTML = `
                <div class="review-card w-100 ml-2 p-1" style="border-right: 2px solid #333; background-color: rgba(0, 0, 0, 0.8);">
                    <div class="card-body review-card-body">
                        <div class="review-header" style="position: relative;">
                            <h2 class="review-username">${review.user}</h2>
                            ${
                                review.user_id === currentUserID ? 
                                `<button id="edit-review-${review.id}" class="review-button">
                                    <i class="fas fa-edit"></i>
                                </button>` 
                                : ''
                            }
                        </div>
                        <p class="review-card-text">Rating: ${review.rating} stars</p>
                        <p class="review-card-text-content"> "${review.comment}"</p>
                        <p class="review-card-text"><small>Posted on: ${review.created_at}</small></p>

                        <h3 class="review-chat-icon" id="comment-icon-${review.id}" style="cursor:pointer;">
                                        <i class="fas fa-comments"></i> 
                                        <span class="comment-count">(${review.comments.length})</span>
                        </h3>                        
                        <ul id="comment-list-${review.id}" style="display:none;" ></ul>
                    </div>
                </div>
                `;

                    const commentsList = reviewElement.querySelector(`#comment-list-${review.id}`);
                    // Add click event listener to the comment icon
                    const commentIcon = reviewElement.querySelector(`#comment-icon-${review.id}`);
                    commentIcon.addEventListener('click', () => {
                        // Toggle visibility of the comments list
                        if (commentsList.style.display === 'none' || commentsList.style.display === '') {
                            commentsList.style.display = 'block'; // Show comments
                        } else {
                            commentsList.style.display = 'none'; // Hide comments
                        }
                    });

                    // Loop through comments and add them to the review
                    review.comments.forEach(comment => {
                        const commentElement = document.createElement('li');
                        commentElement.classList.add('comment-item'); // Add a class for styling

                        // Use spans to allow for individual styling
                        commentElement.innerHTML = `
                            <span class="username">${comment.user}</span>: 
                            <span class="comment-text">${comment.text}</span> 
                            (<span class="created-at">${comment.created_at}</span>)
                        `;

                        commentsList.appendChild(commentElement);
                    });


                    // Append each review column to the row
                    rowElement.appendChild(reviewElement);

                    // Ensure the Edit button is handled correctly
                    const editButton = document.getElementById(`edit-review-${review.id}`);
                    if (editButton) {
                        editButton.addEventListener('click', function () {
                            showMessageReview(`Edit Review clicked for review ID: ${review.id}`);
                            openEditReviewModal(review);
                        });
                    }
                });
            })
            .catch(error => {
                console.error('Error loading reviews:', error);
            });
    }
    // Function to dynamically create and open the modal for writing reviews
    function openReviewModal() {
        // Create the modal HTML dynamically
        const modalHTML = `
    <div class="modal fade custom-review-modal" id="reviewModal" tabindex="-1" role="dialog" aria-labelledby="reviewModalLabel" aria-hidden="true">
        <div class="modal-dialog custom-modal-dialog" role="document">
            <div class="modal-content custom-modal-content">
                <div class="modal-header custom-modal-header">
                    <h5 class="modal-title custom-modal-title" id="reviewModalLabel">Write a Review</h5>
                    <button type="button" class="close custom-close-button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body custom-modal-body">
                    <form id="dynamic-review-form" class="custom-review-form">
                        <div class="form-group custom-form-group">
                            <label for="rating" class="custom-label">Rating</label>
                            <select name="rating" id="rating" class="custom-select">
                                <option value="1">1 Star</option>
                                <option value="2">2 Stars</option>
                                <option value="3">3 Stars</option>
                                <option value="4">4 Stars</option>
                                <option value="5">5 Stars</option>
                            </select>
                        </div>
                        <div class="form-group custom-form-group">
                            <label for="comment" class="custom-label">Comment</label>
                            <textarea class="custom-textarea" id="comment" name="comment" rows="3"></textarea>
                        </div>
                        <button type="submit" class="custom-submit-button">Submit Review</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    `;

        // Append modal to the body
        document.body.insertAdjacentHTML('beforeend', modalHTML);

        // Show the modal
        $('#reviewModal').modal('show');

        // Handle form submission
        const reviewForm = document.getElementById('dynamic-review-form');
        reviewForm.addEventListener('submit', function (event) {
            event.preventDefault();
            const formData = new FormData(reviewForm);

            // Submit the form via AJAX
            fetch('/reviews/api/write/', {
                    method: 'POST',
                    headers: {
                        'X-CSRFToken': getCookie('csrftoken'),
                    },
                    body: formData
                })
                .then(response => {
                    if (response.ok) {
                        return response.json();
                    } else {
                        throw new Error('Error submitting the review.');
                    }
                })
                .then(data => {
                    // Handle successful form submission
                    showMessageReview('Review submitted successfully!');
                    $('#reviewModal').modal('hide');
                    location.reload(); // Optionally reload the page to update the review list
                })
                .catch(error => {
                    console.error('Error:', error);
                    showMessageReview('There was an error submitting your review. Please try again.');
                });
        });
    }
    // Function to open the Edit Review modal dynamically
    function openEditReviewModal(review) {
        const modalHTML = `
    <div class="modal fade custom-review-modal" id="editReviewModal" tabindex="-1" role="dialog" aria-labelledby="editReviewModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editReviewModalLabel">Edit Review</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="edit-review-form">
                        <div class="form-group">
                            <label for="edit-rating">Rating</label>
                            <select name="rating" id="edit-rating" class="form-control">
                                <option value="1" ${review.rating === 1 ? 'selected' : ''}>1 Star</option>
                                <option value="2" ${review.rating === 2 ? 'selected' : ''}>2 Stars</option>
                                <option value="3" ${review.rating === 3 ? 'selected' : ''}>3 Stars</option>
                                <option value="4" ${review.rating === 4 ? 'selected' : ''}>4 Stars</option>
                                <option value="5" ${review.rating === 5 ? 'selected' : ''}>5 Stars</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="edit-comment">Comment</label>
                            <textarea class="form-control" id="edit-comment" name="comment" rows="3">${review.comment}</textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">Update Review</button>
                        <button type="button" class="btn btn-danger" id="delete-review" data-review-id="${review.id}">Delete Review</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    `;

        // Append modal to the body
        document.body.insertAdjacentHTML('beforeend', modalHTML);

        // Show the modal
        $('#editReviewModal').modal('show');

        // Handle form submission for updating the review
        const editForm = document.getElementById('edit-review-form');
        editForm.addEventListener('submit', function (event) {
            event.preventDefault();
            const formData = new FormData(editForm);
            formData.append('review_id', review.id); // Add the review ID for the update

            // Submit the form via AJAX
            fetch('/reviews/api/update_review/', {
                    method: 'POST',
                    headers: {
                        'X-CSRFToken': getCookie('csrftoken'),
                    },
                    body: formData
                })
                .then(response => {
                    if (response.ok) {
                        return response.json();
                    } else {
                        throw new Error('Error updating the review.');
                    }
                })
                .then(data => {
                    showMessageReview('Review updated successfully!');
                    $('#editReviewModal').modal('hide');
                    location.reload(); // Reload to refresh the reviews
                })
                .catch(error => {
                    console.error('Error:', error);
                    showMessageReview('There was an error updating your review. Please try again.');
                });
        });

        // Handle delete review button
        document.getElementById('delete-review').addEventListener('click', function () {
            const reviewId = this.dataset.reviewId;

            if (confirm('Are you sure you want to delete this review?')) {
                fetch(`/reviews/api/delete_review/${reviewId}/`, {
                        method: 'DELETE',
                        headers: {
                            'X-CSRFToken': getCookie('csrftoken'),
                        },
                    })
                    .then(response => {
                        if (response.ok) {
                            showMessageReview('Review deleted successfully!');
                            $('#editReviewModal').modal('hide');
                            location.reload(); // Reload to refresh the reviews
                        } else {
                            throw new Error('Error deleting the review.');
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        showMessageReview('There was an error deleting your review. Please try again.');
                    });
            }
        });
    }

    // Helper function to get the CSRF token
    function getCookie(name) {
        let cookieValue = null;
        if (document.cookie && document.cookie !== '') {
            const cookies = document.cookie.split(';');
            for (let i = 0; i < cookies.length; i++) {
                const cookie = cookies[i].trim();
                if (cookie.substring(0, name.length + 1) === (name + '=')) {
                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                    break;
                }
            }
        }
        return cookieValue;
    }
    // Load reviews when the page loads
    loadReviews();

    // Add click event to the icon to toggle visibility
    icon.addEventListener('click', function () {
        if (reviewsContainer.style.display === 'none' || reviewsContainer.style.display === '') {
            reviewsContainer.style.display = 'block'; // Show the container
        } else {
            reviewsContainer.style.display = 'none'; // Hide the container
        }
    });
});