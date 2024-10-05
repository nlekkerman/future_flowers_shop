document.addEventListener("DOMContentLoaded", function () {

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
    closeButton.textContent = 'Close';
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
    function showMessageAdmin(message) {
        modalMessage.textContent = message; // Set the message text
        messageModal.style.display = 'flex'; // Show the modal
    }

  // Function to create a new seed
    function createSeed() {
        const createSeedForm = document.getElementById('create-seed-form');
        createSeedForm.addEventListener('submit', function(event) {
            event.preventDefault(); // Prevent the default form submission

            const formData = new FormData(this); // Create FormData object

            fetch('/seeds/seeds/create/', { // Update with your actual creation URL
                method: 'POST', // Use POST for creation
                body: formData,
                headers: {
                    'X-CSRFToken': getCookie('csrftoken'), // CSRF protection
                },
            })
            .then(response => {
                if (response.ok) {
                    showMessageAdmin('Seed created successfully!'); // Show success message
                    // Optionally, refresh the seed list or clear the form
                    fetchSeeds(); // Call a function to refresh the seed list
                } else {
                    showMessageAdmin('Failed to create seed.'); // Show error message
                }
            })
            .catch(error => {
                console.error('Error creating seed:', error);
                showMessageAdmin('An error occurred while creating the seed.');
            });
        });
    }


    fetch('/seeds/api/seeds/')
        .then(response => response.json())
        .then(data => {
            const seedListContainer = document.getElementById('seed-list');
            if (!seedListContainer) {
                console.error('Element with ID "seed-list" not found in the DOM.');
                return; // Exit if the element doesn't exist
            }
            
            seedListContainer.innerHTML = ''; // Clear any existing content

            if (data.success) {
                // Loop through the seeds and create a list item for each
                // Loop through the seeds and create a list item for each
                data.seeds.forEach(seed => {
                    // Create list item
                    const listItem = document.createElement('li');
                    listItem.className = 'seed-list-item'; // Add class for styling

                    // Create a span for seed name with styling
                    const seedName = document.createElement('span');
                    seedName.className = 'seed-name'; // Add class for seed name
                    seedName.textContent = `${seed.name} (${seed.scientific_name})`;

                    // Create Edit link
                    const editLink = document.createElement('a');
                    editLink.textContent = 'Edit';
                    editLink.className = 'edit-link'; // Add class for edit link

                    // Event listener to open the modal and populate data
                    editLink.addEventListener('click', function (event) {
                        event.preventDefault(); // Prevent the default action of the link
                        openEditSeedModal(seed); // Call the function to open the modal and pass the seed data
                        
                    });

                    // Create Delete link
                    const deleteLink = document.createElement('a');
                    deleteLink.textContent = 'Delete';
                    deleteLink.className = 'delete-link'; // Add class for delete link
                    deleteLink.onclick = function (event) {
                        event.preventDefault(); // Prevent default link behavior
                        if (confirm('Are you sure you want to delete this seed?')) {
                            // Perform delete action here
                            fetch(`/seeds/seeds/${seed.id}/delete/`, {
                                    method: 'DELETE', // Assuming your delete method
                                    headers: {
                                        'X-CSRFToken': getCookie('csrftoken'), // CSRF protection
                                    },
                                })
                                .then(response => {
                                    if (response.ok) {
                                        seedListContainer.removeChild(listItem);
                                        showMessageAdmin('Seed deleted successfully.'); // Show message
                                    } else {
                                        showMessageAdmin('Failed to delete seed.'); // Show error message
                                    }
                                })
                                .catch(error => {
                                    console.error('Error deleting seed:', error);
                                    showMessageAdmin('An error occurred while deleting the seed.');

                                });
                        }
                    };

                    // Append seed name and buttons to the list item
                    listItem.appendChild(seedName);
                    listItem.appendChild(editLink);
                    listItem.appendChild(deleteLink);

                    // Append the list item to the container
                    seedListContainer.appendChild(listItem);
                });


            } else {
                const errorItem = document.createElement('li');
                errorItem.textContent = 'Failed to load seeds.';
                seedListContainer.appendChild(errorItem);
            }
        })
        .catch(error => {
            console.error('Error fetching seeds:', error);
        });

        function openEditSeedModal(seed) {
            document.getElementById('edit-seed-id').value = seed.id; // Set the ID for the hidden field
            document.getElementById('edit-seed-name').value = seed.name;
            document.getElementById('edit-seed-scientific-name').value = seed.scientific_name;
            document.getElementById('edit-seed-description').value = seed.description;
            document.getElementById('edit-seed-price').value = seed.price;
            document.getElementById('edit-seed-discount').value = seed.discount;
            document.getElementById('edit-planting_months_from').value = seed.planting_months_from;
            document.getElementById('edit-planting_months_to').value = seed.planting_months_to;
            document.getElementById('edit-flowering_months_from').value = seed.flowering_months_from;
            document.getElementById('edit-flowering_months_to').value = seed.flowering_months_to;
            document.getElementById('edit-height_from').value = Math.floor(seed.height_from);
            document.getElementById('edit-height_to').value = Math.floor(seed.height_to);
            document.getElementById('edit-sun_preference').value = seed.sun_preference;
            document.getElementById('edit-in-stock').checked = seed.is_in_stock;
        
            // Set the action URL for the form dynamically
            const editForm = document.getElementById('edit-seed-form');
            editForm.action = `/seeds/seeds/${seed.id}/edit/`; // Update with correct edit URL
        
            // Show the modal
            document.getElementById('editSeedModal').style.display = 'block';
        }
        
        // Add an event listener for form submission
        document.getElementById('edit-seed-form').addEventListener('submit', function(event) {
            event.preventDefault(); // Prevent the default form submission
        
            const formData = new FormData(this); // Create FormData object
        
            fetch(this.action, {
                method: 'POST', // or 'PUT' based on your backend
                body: formData,
                headers: {
                    'X-CSRFToken': getCookie('csrftoken'), // CSRF protection
                },
            })
            .then(response => {
                if (response.ok) {
                    showMessageAdmin('Seed updated successfully.'); // Show success message
                    closeEditSeedModal(); // Close the modal after successful update
                    // Optionally, refresh the seed list or update the UI accordingly here
                } else {
                    showMessageAdmin('Failed to update seed.'); // Show error message
                }
            })
            .catch(error => {
                console.error('Error updating seed:', error);
                showMessageAdmin('An error occurred while updating the seed.');
            });
        });
        
    // Function to close the edit seed modal
    function closeEditSeedModal() {
        document.getElementById('editSeedModal').style.display = 'none';
    }

    // Add event listener to the close button
    document.querySelector('.edit-seed-modal-close').addEventListener('click', closeEditSeedModal);

    // Optional: Close the modal when clicking outside of it
    window.onclick = function (event) {
        const modal = document.getElementById('editSeedModal');
        if (event.target === modal) {
            closeEditSeedModal();
        }
    }
    // Function to get CSRF token for AJAX requests
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
});

