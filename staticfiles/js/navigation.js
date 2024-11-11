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
        "https://future-flower-shop-7f6f515e140f.herokuapp.com/",
       
    ];

    // Function to update menu icon display based on the URL
    function updateMenuDisplay() {
        const currentUrl = window.location.href;
        const isHome = homeUrls.includes(currentUrl);

        if (isHome) {

            menuIcon.style.display = "block";
            logoContainer.style.opacity = '1';
            logoContainer.style.visibility = 'visible';
            fixedMenuIcon.style.display = "none";
        } else {

            navigationContainer.style.width = '100%'
            navigationContainer.style.height = '100%'
            fixedMenuIcon.style.display = "block";
            menuIcon.style.display = "none";
            logoContainer.style.opacity = '0';
            logoContainer.style.visibility = 'hidden';
        }
    }


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


document.addEventListener('DOMContentLoaded', function () {
    console.log("SIDEBAR DOM fully loaded. Initializing elements...");

    const menuIcon = document.querySelector('.fixed-menu-icon');
    const rightNavColumn = document.querySelector('.right-nav-column');
    const body = document.body;
    const navigationContainer = document.querySelector('.navigation-container');
    const adminContainer = document.querySelector('.admin-dashboard-container');
    const profileContainer = document.querySelector('.profile-page-main-container');
    const cartContainer = document.querySelector('.cart-container');
    const seedsContainer = document.querySelector('.seeds-container');
    const registerContainer = document.querySelector('.register-form-container');
    const checkoutContainer = document.querySelector('.checkout-container');
    const loginContainer = document.querySelector('.form-container');
    const orderDetailsContainer = document.querySelector('.order-details-container');
    const checkoutSuccessContainer = document.querySelector('.checkout-success-container');
    

    function setZIndex(element, zIndex) {
        if (element) {
            element.style.zIndex = zIndex;
        }
    }

    function toggleSidebar() {
        rightNavColumn.classList.toggle('visible');
        body.classList.toggle('active-blur', rightNavColumn.classList.contains('visible'));

        if (rightNavColumn.classList.contains('visible')) {
            console.log("Sidebar is now visible.");
            rightNavColumn.style.zIndex = '1002';
            navigationContainer.style.zIndex = '1002';
            setZIndex(adminContainer, '1');
            setZIndex(cartContainer, '1');
            setZIndex(profileContainer, '1');
            setZIndex(seedsContainer, '1');
            setZIndex(checkoutContainer, '1');
            setZIndex(registerContainer, '1');
            setZIndex(loginContainer, '1');
            setZIndex(orderDetailsContainer, '1');
            setZIndex(checkoutSuccessContainer, '1');


            profileContainer.style.zIndex = '1';
        } else {
            console.log("Sidebar is now hidden.");
            rightNavColumn.style.zIndex = '1';
            navigationContainer.style.zIndex = '1';
            setZIndex(adminContainer, '12');
            setZIndex(cartContainer, '12');
            setZIndex(profileContainer, '12');
            setZIndex(seedsContainer, '12');
            setZIndex(checkoutContainer, '12');
            setZIndex(registerContainer, '12');
            setZIndex(loginContainer, '12');
            setZIndex(orderDetailsContainer, '12');
            setZIndex(checkoutSuccessContainer, '12');

        }

        // Log the current z-index values for debugging
        console.log("Z-index values updated:", {
            rightNavColumnZIndex: rightNavColumn.style.zIndex,
            navigationContainerZIndex: navigationContainer.style.zIndex,
            adminContainerZIndex: adminContainer ? adminContainer.style.zIndex : 'N/A', // Handle null case
            cartContainerZIndex: cartContainer.style.zIndex
        });
    }

    // Toggle sidebar visibility on menu icon click
    menuIcon.addEventListener('click', function () {
        console.log("Menu icon clicked. Toggling sidebar...");
        toggleSidebar();
    });

});


document.addEventListener('DOMContentLoaded', () => {
    const viewSeedsButton = document.getElementById('view-seeds-button');
    if (viewSeedsButton) {
        viewSeedsButton.addEventListener('click', () => {
            window.location.href = '/seeds/?show_seeds=true';
        });
    }
});

document.addEventListener('DOMContentLoaded', () => {
    const viewSeedsButton = document.getElementById('shop-icon');
    if (viewSeedsButton) {
        viewSeedsButton.addEventListener('click', () => {
            window.location.href = '/seeds/?show_seeds=true';
        });
    }
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