document.addEventListener("DOMContentLoaded", function () {
    const fixedMenuIcon = document.querySelector(".fixed-menu-icon");
    const logoContainer = document.getElementById("logoContainer");
    const navigationContainer = document.querySelector('.navigation-container');
   


    const homeUrls = [
        "https://8000-nlekkerman-futureflower-v9397r1bhgn.ws.codeinstitute-ide.net/",
        "https://future-flower-shop-7f6f515e140f.herokuapp.com/",
       
    ];

    // Function to update menu icon display based on the URL
    function updateMenuDisplay() {
        const currentUrl = window.location.href;
        const isHome = homeUrls.includes(currentUrl);

        if (isHome) {

            logoContainer.style.opacity = '1';
            logoContainer.style.visibility = 'visible';
            fixedMenuIcon.style.display = "none";
        } else {

            navigationContainer.style.width = '100%'
            fixedMenuIcon.style.display = "block";
            logoContainer.style.opacity = '0';
            logoContainer.style.visibility = 'hidden';
        }
    }


    updateMenuDisplay();

 
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
    const header = document.querySelector('.header');
    const searchContainer = document.querySelector('.search-wrapper');
    const filterToggle = document.querySelector('.filter-toggle');
    
    
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
            setZIndex(header, '1');
            setZIndex(searchContainer, '1');
            setZIndex(filterToggle, '1');
          


            profileContainer.style.zIndex = '1';
        } else {
            console.log("Sidebar is now hidden.");
            rightNavColumn.style.zIndex = '12';
            navigationContainer.style.zIndex = '12';
            setZIndex(adminContainer, '12');
            setZIndex(cartContainer, '12');
            setZIndex(profileContainer, '12');
            setZIndex(seedsContainer, '12');
            setZIndex(checkoutContainer, '12');
            setZIndex(registerContainer, '12');
            setZIndex(loginContainer, '12');
            setZIndex(orderDetailsContainer, '12');
            setZIndex(checkoutSuccessContainer, '12');
            setZIndex(header, '1002');
            setZIndex(searchContainer, '1002');
            setZIndex(filterToggle, '1002');


        }

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