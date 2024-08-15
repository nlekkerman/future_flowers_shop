document.addEventListener('DOMContentLoaded', function() {
    const navigationContainer = document.querySelector('.navigation-container');

    // Toggle the position of the navigation container when it is clicked
    navigationContainer.addEventListener('click', function() {
        if (navigationContainer.classList.contains('centered')) {
            // If it's centered, remove the centered class and move it back to the top-right corner
            navigationContainer.classList.remove('centered');
            navigationContainer.style.top = '60px';
            navigationContainer.style.right = '40px';
            navigationContainer.style.left = 'auto'; // Reset left position
            navigationContainer.style.transform = 'none'; // Reset transform
            navigationContainer.style.width = '100px'; // Reset transform
            navigationContainer.style.height = '100px'; // Reset transform
        } else {
            // If it's not centered, add the centered class and move it to the center
            navigationContainer.classList.add('centered');
            navigationContainer.style.top = '50%';
            navigationContainer.style.left = '50%';
            navigationContainer.style.transform = 'translate(-50%, -50%)';
            navigationContainer.style.right = 'auto'; // Reset right position
            navigationContainer.style.width = '300px'; // Reset transform
            navigationContainer.style.height = '300px'; // Reset transform
        }
    });
});
