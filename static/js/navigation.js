document.addEventListener("DOMContentLoaded", function() {
    const menuIcon = document.getElementById("menuIcon");
    const topRow = document.querySelector(".nav-top-row");
    const bottomRow = document.querySelector(".nav-bottom-row");
    const navigationContainer = document.querySelector('.navigation-container');
    const body = document.body; // Reference to the body element
    let isOpen = false;

    // Function to update menu position based on page
    function updateMenuPosition() {
        // Check if the current URL matches the home URL
        const isHome = window.location.href === "https://8000-nlekkerman-futureflower-v9397r1bhgn.ws.codeinstitute-ide.net/";

        if (isOpen) {
            // If the menu is open, keep it centered
            navigationContainer.classList.add('centered');
            navigationContainer.classList.remove('bottom-right');
        } else if (!isOpen && !isHome) {
            // If the menu is closed and it's not the homepage, position the menu in the bottom-right
            navigationContainer.classList.add('bottom-right');
            navigationContainer.classList.remove('centered');
        } else {
            // If it's on the homepage and the menu is closed, keep it centered
            navigationContainer.classList.add('centered');
            navigationContainer.classList.remove('bottom-right');
        }
    }

    // Initial call to set position
    updateMenuPosition();

    menuIcon.addEventListener("click", function() {
        isOpen = !isOpen; // Toggle the menu state

        if (isOpen) {
            topRow.style.display = "flex";
            bottomRow.style.display = "flex";

            // Always center the menu when opened
            navigationContainer.classList.add('centered');
            navigationContainer.classList.remove('bottom-right');

            // Add blur effect
            body.classList.add('active-blur');

            // Animate the top row icons
            const topIcons = topRow.querySelectorAll(".nav-link-icon");
            topIcons.forEach((icon, index) => {
                setTimeout(() => {
                    icon.style.opacity = 1;
                }, index * 300);
            });

            // Animate the bottom row icons
            const bottomIcons = bottomRow.querySelectorAll(".nav-link-icon");
            bottomIcons.forEach((icon, index) => {
                setTimeout(() => {
                    icon.style.opacity = 1;
                }, (index + topIcons.length) * 300);
            });

        } else {
            // Hide the icons when closing the menu
            const topIcons = topRow.querySelectorAll(".nav-link-icon");
            const bottomIcons = bottomRow.querySelectorAll(".nav-link-icon");

            [...topIcons, ...bottomIcons].forEach((icon, index) => {
                setTimeout(() => {
                    icon.style.opacity = 0; // Hide each icon with a delay
                }, index * 300);
            });

            // After all icons are hidden, move the menu and remove the blur effect
            setTimeout(() => {
                topRow.style.display = "none"; // Hide the top row
                bottomRow.style.display = "none"; // Hide the bottom row
                body.classList.remove('active-blur'); // Remove blur effect
                updateMenuPosition(); // Update menu position based on the current page
            }, (topIcons.length + bottomIcons.length) * 300); // Wait until all icons are hidden
        }
    });

    // Listen for URL changes (for single-page applications or dynamic URL changes)
    window.addEventListener('popstate', updateMenuPosition);
});


// navigation.js
console.log('navigation.js loaded'); // Log when this script is loaded

document.addEventListener('DOMContentLoaded', () => {
    const viewSeedsButton = document.getElementById('view-seeds-button');
    if (viewSeedsButton) {
        viewSeedsButton.addEventListener('click', () => {
            window.location.href = '/seeds/?show_seeds=true'; // Adjust to the Django URL
        });
    }
});

document.addEventListener('DOMContentLoaded', () => {
    const viewSeedsButton = document.getElementById('close-order-success-button');
    if (viewSeedsButton) {
        viewSeedsButton.addEventListener('click', () => {
            console.log("CILIKICIAKSADA"); // This should be logged when clicked
            window.location.href = '/seeds/?show_seeds=true'; // Adjust to your URL or route
        });
    } else {
        console.log("Button not found");
    }
});
document.addEventListener('DOMContentLoaded', () => {
    const viewSeedsButton = document.getElementById('back-to-shopping-button');
    if (viewSeedsButton) {
        viewSeedsButton.addEventListener('click', () => {
            window.location.href = '/seeds/?show_seeds=true';
        });
    }
});
