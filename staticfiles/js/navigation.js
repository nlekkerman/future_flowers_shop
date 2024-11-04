document.addEventListener("DOMContentLoaded", function () {
    const menuIcon = document.getElementById("menuIcon");
    const fixedMenuIcon = document.querySelector(".fixed-menu-icon");
    const logoContainer = document.getElementById("logoContainer");
    const topRow = document.querySelector(".nav-top-row");
    const bottomRow = document.querySelector(".nav-bottom-row");
    const navigationContainer = document.querySelector('.navigation-container');
    const body = document.body;
    let isOpen = false;


    const homeUrls = [
        "https://8000-nlekkerman-futureflower-v9397r1bhgn.ws.codeinstitute-ide.net/",
        "https://future-flower-shop-7f6f515e140f.herokuapp.com/" // Add actual deployed URL here
    ];

    // Function to update menu icon display based on the URL
    function updateMenuDisplay() {
        const currentUrl = window.location.href;
        const isHome = homeUrls.includes(currentUrl);

        if (isHome) {
            // Show the main menu icon and logo, hide the fixed menu icon
            menuIcon.style.display = "block";
            logoContainer.style.opacity = '1';
            logoContainer.style.visibility = 'visible';
            fixedMenuIcon.style.display = "none";
        } else {
            // Show the fixed menu icon, hide the main menu icon and logo
            fixedMenuIcon.style.display = "block";
            menuIcon.style.display = "none";
            logoContainer.style.opacity = '0';
            logoContainer.style.visibility = 'hidden';
        }
    }

    // Call updateMenuDisplay on page load
    updateMenuDisplay();

    // Update menu display when clicking menu icon
    menuIcon.addEventListener("click", function () {
        isOpen = !isOpen;

        if (isOpen) {
            topRow.style.display = "flex";
            bottomRow.style.display = "flex";
            body.classList.add('active-blur');

            const topIcons = topRow.querySelectorAll(".nav-link-icon");
            topIcons.forEach((icon, index) => {
                setTimeout(() => {
                    icon.style.opacity = 1;
                }, index * 300);
            });

            const bottomIcons = bottomRow.querySelectorAll(".nav-link-icon");
            bottomIcons.forEach((icon, index) => {
                setTimeout(() => {
                    icon.style.opacity = 1;
                }, (index + topIcons.length) * 300);
            });
        } else {
            const icons = [...topRow.querySelectorAll(".nav-link-icon"), ...bottomRow.querySelectorAll(".nav-link-icon")];
            icons.forEach((icon, index) => {
                setTimeout(() => {
                    icon.style.opacity = 0;
                }, index * 300);
            });

            setTimeout(() => {
                topRow.style.display = "none";
                bottomRow.style.display = "none";
                body.classList.remove('active-blur');
                updateMenuDisplay();
            }, icons.length * 300);
        }
    });

    // Listen for URL changes
    window.addEventListener('popstate', updateMenuDisplay);
});




document.addEventListener('DOMContentLoaded', () => {
    const viewSeedsButton = document.getElementById('close-order-success-button');
    if (viewSeedsButton) {
        viewSeedsButton.addEventListener('click', () => {
            window.location.href = '/seeds/?show_seeds=true'; 
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