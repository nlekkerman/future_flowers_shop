import {
    fetchUserId
} from './control.js';

document.addEventListener('DOMContentLoaded', function () {
    const body = document.body;
    const icon = document.getElementById('icon');
    const reviewsIcon = document.getElementById('reviews-icon');
    const reviewsContainer = document.getElementById('reviews-container');
    const messageModal = document.createElement('div');
    messageModal.id = 'modal-overlay-background'; 
    messageModal.className = 'modal-overlay-background';
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
    
    const modalContent = document.createElement('div');
    modalContent.className = 'modal-box-content';


    const modalMessage = document.createElement('p');


    const closeButton = document.createElement('button');
    closeButton.className = 'button-close-modal';
    closeButton.textContent = 'x';
    closeButton.onclick = function () {
        messageModal.style.display = 'none';


    };

    // Append the message and close button to the modal content
    modalContent.appendChild(closeButton);

    modalContent.appendChild(modalMessage);

    // Append the modal content to the modal container
    messageModal.appendChild(modalContent);

    // Add the modal container to the body
    document.body.appendChild(messageModal);

    // Function to display the message modal
    function showMessageReview(message) {
        modalMessage.textContent = message;
        messageModal.style.display = 'flex';
        messageModal.style.zIndex = '999999999999999';
    }
    // Function to load reviews
    async function loadReviews() {
      
        const currentUserID = await fetchUserId(); // Use the fetchUserId function from control.js

        if (currentUserID === null) {
            console.error('Unable to retrieve current user ID.');
            return;
        }

        // Fetch the reviews from the API
        fetch('/reviews/api/reviews/')
            .then(response => {

                // Check if the response is OK (status code 200)
                if (!response.ok) {
                    throw new Error(`Network response was not ok: ${response.status} ${response.statusText}`);
                }

                // Parse the JSON response
                return response.json();
            })
            .then(data => {
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

                closeButton.addEventListener('click', function () {

                    reviewsContainer.classList.remove('show');
                    body.classList.remove('active-blur');
                });
                reviewsContainer.appendChild(closeButton); // Add close button to container

                // Create and add the Write Review button at the top
                const writeReviewButton = document.createElement('button');
                writeReviewButton.id = 'write-review';
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
                    const reviewElement = document.createElement('div');
                    reviewElement.classList.add('col-12', 'col-md-6', 'col-lg-4', 'col-xl-2', 'd-flex', 'custom-with-fit');

                    reviewElement.innerHTML = `
                                                    <div class="review-card w-100 ml-2 p-1" style="border-right: 2px solid #333;">
                                                        <div class="card-body review-card-body">
                                                            <div class="review-header" style="position: relative;">
                                                                <h2 class="review-username">${review.user}</h2>
                                                                ${review.user_id === currentUserID ? 
                                                                    `<button id="edit-review-${review.id}" class="review-button">
                                                                        <i class="fas fa-edit"></i>
                                                                    </button>` 
                                                                : ''}
                                                            </div>
                                                            <p class="review-card-text">Rating: ${review.rating} stars</p>
                                                            <p class="review-card-text-content"> "${review.comment}"</p>
                                                            <p class="review-card-text"><small>Posted on: ${review.created_at}</small></p>
                                                            <div class="comments-icons-container">
                                                            <h3 class="review-chat-icon" id="comment-icon-${review.id}" style="cursor:pointer;">
                                                                <i class="fas fa-comments"></i> 
                                                                <span class="comment-count">(${review.comments.length})</span>
                                                            </h3>  
                                                            <h3 class="review-chat-icon" id="leave-comment-icon-${review.id}" style="cursor:pointer; display: inline-block; margin-left: 10px;">
                                                                <i class="fas fa-pencil-alt"></i>
                                                            </h3>     
                                                            </div>                 
                                                            <ul id="comment-list-${review.id}" style="display:none;"></ul>
                                                        </div>
                                                    </div>
                                                `;

                    const commentsList = reviewElement.querySelector(`#comment-list-${review.id}`);
                    // Add click event listener to the comment icon
                    const commentIcon = reviewElement.querySelector(`#comment-icon-${review.id}`);
                    commentIcon.addEventListener('click', () => {
                        // Toggle visibility of the comments list
                        commentsList.style.display = (commentsList.style.display === 'none' || commentsList.style.display === '') ? 'block' : 'none';
                    });

                    // Add click event listener to the leave comment icon
                    const leaveCommentIcon = reviewElement.querySelector(`#leave-comment-icon-${review.id}`);
                    leaveCommentIcon.addEventListener('click', () => {
                        openCommentModal(review.id); // Function to open the modal for leaving a comment
                    });

                    // Loop through comments and add them to the review
                    review.comments.forEach(comment => {
                  
                        const commentElement = document.createElement('li');
                        commentElement.classList.add('comment-item'); // Add a class for styling

                        commentElement.innerHTML = `
                                                    <span class="username">${comment.user}</span>: 
                                                    <span class="comment-text" id="comment-text-${comment.id}">${comment.text}</span> 
                                                    (<span class="created-at">${comment.created_at}</span>)
                                                    <button class="edit-comment-button" data-comment-id="${comment.id}">
                                                        <i class="fas fa-edit"></i> 
                                                    </button>
                                                    <button class="delete-comment-button" data-comment-id="${comment.id}">
                                                        <i class="fas fa-trash"></i> 
                                                    </button>
                                                `;

                        // Attach the click event listener to the button
                        const editButton = commentElement.querySelector('.edit-comment-button');
                        editButton.addEventListener('click', () => {
                            const commentId = editButton.getAttribute('data-comment-id'); 
                            openEditCommentModal(review.id, commentId, comment.text); 
                        });
                        // Attach the click event listener to the delete button
                        const deleteButton = commentElement.querySelector('.delete-comment-button');
                        deleteButton.addEventListener('click', () => {
                            const commentId = deleteButton.getAttribute('data-comment-id'); 
                            selectedCommentId = commentId;
                            selectedReviewId = review.id;
                            createDeleteModal(); 
                            $('#deleteModal').modal('show'); 
                        });

                        // Append the comment element to the comments list
                        commentsList.appendChild(commentElement);
                    });


                    rowElement.appendChild(reviewElement);

                    // Ensure the Edit button is handled correctly
                    const editButton = document.getElementById(`edit-review-${review.id}`);
                    if (editButton) {
                        editButton.addEventListener('click', function () {
                            openEditReviewModal(review);
                        });
                    }


                });

            })
            .catch(error => {
                console.error('Error loading reviews:', error);
            });

        function openCommentModal(reviewId, commentId = null) {
            const modalHTML = `
                    <div class="modal fade custom-comment-modal" id="commentModal" tabindex="-1" role="dialog" aria-labelledby="commentModalLabel" aria-hidden="true">
                        <div class="modal-dialog custom-modal-dialog" role="document">
                            <div class="modal-content custom-modal-content">
                                <div class="custom-modal-header">
                                    <h5 class="custom-modal-title" id="commentModalLabel">${commentId ? 'Edit Comment' : 'Leave a Comment'}</h5>
                                    
                                </div>
                                <div class="modal-body custom-modal-body">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                    <form id="comment-form">
                                        <div class="form-group">
                                            <label class="custom-label" for="comment">Comment</label>
                                            <textarea class="custom-textarea" id="comment" name="comment" rows="3" required></textarea>
                                        </div>
                                        <button type="submit" class="btn ">${commentId ? 'Update Comment' : 'Submit Comment'}</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                `;

            // Append modal to the body
            document.body.insertAdjacentHTML('beforeend', modalHTML);

            // Populate the textarea if editing a comment
            if (commentId) {
                const commentText = document.querySelector(`#comment-text-${commentId}`).textContent;
                document.getElementById('comment').value = commentText;
            }

            // Show the modal
            $('#commentModal').modal('show');

            // Handle form submission
            const commentForm = document.getElementById('comment-form');
            commentForm.addEventListener('submit', function (event) {
                event.preventDefault();

                // Create the comment object
                const commentText = document.getElementById('comment').value;

                // Prepare the data for the request
                const data = {
                    text: commentText,
                    ...(commentId && {
                        comment_id: commentId
                    }) // Add commentId if it exists
                };

                // Determine the correct API endpoint based on whether we are editing
                const method = commentId ? 'PUT' : 'POST'; // Use PUT for editing
                const url = `/reviews/api/comment/leave/${reviewId}/`;


                // Send the request
                fetch(url, {
                        method: method,
                        headers: {
                            'Content-Type': 'application/json', // Set the content type to JSON
                            'X-CSRFToken': getCookie('csrftoken'), // Include CSRF token for Django
                        },
                        body: JSON.stringify(data) // Send the data as JSON
                    })
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Error submitting the comment.');
                        }
                        return response.json();
                    })
                    .then(data => {
                        showMessageReview(`Comment submitted waiting for approval: ${commentId ? commentId : 'new comment'}`);
                        $('#commentModal').modal('hide'); // Hide modal after submission
                    })
                    .catch(error => {
                        console.error('Error submitting comment:', error);
                    });
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
                                                
                                            </div>
                                            <div class="modal-body custom-modal-body">
                                                <button type="button" class="close custom-close-button" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
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
                                                    <button type="submit" class="btn">Submit Review</button>
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

            const reviewForm = document.getElementById('dynamic-review-form');
            reviewForm.addEventListener('submit', function (event) {
                event.preventDefault();
                
                const comment = document.getElementById('comment').value.trim();
                        
                // Validate the comment field for emptiness and length
                if (!comment) {
                    alert("Review comment cannot be empty.");
                    return;
                }
                if (comment.length > 500) {
                    alert("Your review cannot exceed 500 characters.");
                    return;
                }
                
            
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
                        showMessageReview('There was an error submitting your review. Please try again.');
                    });
            });
            
        }

        function openEditCommentModal(reviewId, commentId, currentText) {

            // Create modal HTML
            const modalHTML = `
                <div class="modal fade" id="editCommentModal" tabindex="-1" role="dialog" aria-labelledby="commentModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content custom-modal-content">
                            <div class="modal-header custom-modal-header">
                                <h5 class="modal-title custom-modal-title" id="commentModalLabel">Edit Comment</h5>
                            </div>
                            <div class="modal-body custom-modal-body">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                                <form id="comment-form">
                                    <div class="form-group">
                                        <label  class="custom-label" for="comment">Comment</label>
                                        <textarea class="form-control custom-textarea" id="comment" name="comment" rows="3" required>${currentText}</textarea>
                                    </div>
                                    <button type="submit" class="btn">Update Comment</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            `;

            // Append modal to the body
            document.body.insertAdjacentHTML('beforeend', modalHTML);

            // Show the modal using Bootstrap
            $('#editCommentModal').modal('show');

            // Handle form submission
            const commentForm = document.getElementById('comment-form');
            commentForm.onsubmit = function (event) {
                event.preventDefault(); // Prevent the default form submission

                // Prepare the data for the API request
                const updatedCommentText = document.getElementById('comment').value;
                const data = {
                    text: updatedCommentText
                };

                // Send a PUT request to update the comment
                fetch(`/reviews/api/edit_comment/update/${reviewId}/${commentId}/`, {
                        method: 'PUT', // Use PUT for updating comments
                        headers: {
                            'Content-Type': 'application/json',
                            'X-CSRFToken': getCookie('csrftoken'), // Include CSRF token for Django
                        },
                        body: JSON.stringify(data)
                    })
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Error updating the comment.');
                        }
                        return response.json();
                    })
                    .then(data => {
                        $('#editCommentModal').modal('hide'); // Hide modal after submission

                        loadReviews();
                    })
                    .catch(error => {
                    })
                    .finally(() => {
                        // Remove the modal from the DOM after hiding
                        $('#editCommentModal').on('hidden.bs.modal', function () {
                            $(this).remove();
                        });
                    });
            };
        }



        // Utility function to get CSRF token from cookies (Django specific)
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

    }

    // Function to delete a comment
    function deleteComment(reviewId, commentId) {
        const url = `/reviews/api/comment/delete/${reviewId}/${commentId}/`; 
        fetch(url, {
                method: 'DELETE', 
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRFToken': getCookie('csrftoken'),
                }
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Error deleting the comment.');
                }
                return response.json();
            })
            .then(data => {
                showMessageReview("Comment deleted!!")
                loadReviews()


            })
            .catch(error => {
                console.error('Error deleting comment:', error);
            });
    }

    let selectedCommentId = null;
    let selectedReviewId = null;

    // Function to create the delete confirmation modal dynamically
    function createDeleteModal() {
        // Check if modal already exists
        let existingModal = document.getElementById('deleteModal');
        if (!existingModal) {
            const modalHTML = `
            <div id="deleteModal" class="modal" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Confirm Delete</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>Are you sure you want to delete this comment?</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" id="confirmDeleteBtn">Delete</button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
        `;
            document.body.insertAdjacentHTML('beforeend', modalHTML);
        }

        // Add event listener for confirm delete button
        document.getElementById('confirmDeleteBtn').addEventListener('click', function () {
            if (selectedCommentId && selectedReviewId) {
                deleteComment(selectedReviewId, selectedCommentId);
                $('#deleteModal').modal('hide'); // Hide the modal after confirming
            }
        });
    }

    // Add event listener for delete button
    document.addEventListener('click', function (event) {
        if (event.target.classList.contains('delete-comment-button')) {
            selectedCommentId = event.target.getAttribute('data-comment-id');
            selectedReviewId = event.target.closest('.review').getAttribute('data-review-id'); 

            createDeleteModal();
            $('#deleteModal').modal('show'); 
        }
    });

    // Function to open the Edit Review modal dynamically
    function openEditReviewModal(review) {
        const modalHTML = `
        <div class="modal fade custom-review-modal" id="editReviewModal" tabindex="-1" role="dialog" aria-labelledby="editReviewModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content"> <!-- modal-content to wrap the modal structure -->
                    <div class="custom-modal-content">
                        <div class="custom-modal-header">
                            <h5 class="custom-modal-title" id="editReviewModalLabel">Edit Review</h5>
                            <!-- Correct close button, ensure it's inside modal-header -->
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form id="edit-review-form">
                                <div class="form-group">
                                    <label class="custom-label" for="edit-rating">Rating</label>
                                    <select name="rating" id="edit-rating" class="form-control custom-select">
                                        <option value="1" ${review.rating === 1 ? 'selected' : ''}>1 Star</option>
                                        <option value="2" ${review.rating === 2 ? 'selected' : ''}>2 Stars</option>
                                        <option value="3" ${review.rating === 3 ? 'selected' : ''}>3 Stars</option>
                                        <option value="4" ${review.rating === 4 ? 'selected' : ''}>4 Stars</option>
                                        <option value="5" ${review.rating === 5 ? 'selected' : ''}>5 Stars</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label class="custom-label" for="edit-comment">Comment</label>
                                    <textarea class="form-control custom-textarea" id="edit-comment" name="comment" rows="3">${review.comment}</textarea>
                                </div>
                                <button type="submit" class="btn">Update Review</button>
                                <button type="button" class="btn" id="delete-review" data-review-id="${review.id}">Delete Review</button>
                            </form>
                        </div>
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

    loadReviews();

    icon.addEventListener('click', function () {
        reviewsContainer.classList.add('show'); 
        body.classList.add('active-blur');
    });

    // Add click event to `reviewsIcon` to show `reviewsContainer` and apply body blur
    reviewsIcon.addEventListener('click', function () {
        reviewsContainer.classList.add('show'); 
        body.classList.add('active-blur'); 
    });


    reviewsContainer.addEventListener('click', function (event) {
        if (event.target === reviewsContainer) {
            reviewsContainer.classList.remove('show'); // Hide the container
            body.classList.remove('active-blur'); // Remove blur from body
        }
    });



});