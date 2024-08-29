$(document).ready(function () {
    function toggleNavLinks(visible) {
        if (visible) {
            // Resize the menuIcon when nav-link-icons are visible
            $('#menuIcon').stop().animate({
                width: '100px', // Decrease width
                height: '100px' // Decrease height
            }, 500); // Duration for resizing animation

            $('.menu-icon-span').stop().animate({
                opacity: 0.5 // Reduce opacity of the text inside menuIcon
            }, 1000);

            $('.nav-link-icon').each(function (index) {
                let delay = index * 200; // 0.2 seconds interval
                $(this).stop().css({
                    display: 'flex', // Ensure they are displayed
                    pointerEvents: 'auto' // Allow interactions
                }).delay(delay).animate({
                    opacity: 1,
                    transform: 'scale(1)'
                }, 200); // 0.2 seconds for appearance animation
            });
            $('.home-container').addClass('centered-nav');
            $('.navigation-container').addClass('centered-nav');
        } else {
            // Reset menuIcon size when nav-link-icons are hidden
            $('#menuIcon').stop().animate({
                width: '140px', // Original width
                height: '140px' // Original height
            }, 500); // Duration for resizing animation

            $('.menu-icon-span').stop().animate({
                opacity: 1 // Reset opacity for text inside menuIcon
            }, 1000);

            $('.nav-link-icon').each(function (index) {
                $(this).stop().delay(index * 200).animate({
                    opacity: 0,
                    transform: 'scale(0)'
                }, 200, function() {
                    $(this).css({
                        display: 'none', // Hide elements after animation completes
                        pointerEvents: 'none' // Disable interactions
                    });
                });
            });

            // Remove class to position the navigation container back in the top right
            $('.navigation-container').removeClass('centered-nav');
        }
    }

    $('#menuIcon').click(function () {
        if ($('.nav-link-icon').first().css('opacity') === '0') {
            toggleNavLinks(true);
        } else {
            toggleNavLinks(false);
        }
    });

    function positionNavLinks() {
        let numSmallCircles = $('.nav-link-icon').length;
        let angleStep = 360 / numSmallCircles;
        let radius = 100; // Distance from the center of the big circle

        $('.nav-link-icon').each(function (index) {
            let angle = angleStep * index;
            let radians = angle * (Math.PI / 180);
            let x = radius * Math.cos(radians);
            let y = radius * Math.sin(radians);
            $(this).css({
                top: 'calc(50% + ' + y + 'px)',
                left: 'calc(50% + ' + x + 'px)',
                transform: 'translate(-50%, -50%)'
            });
        });
    }

    positionNavLinks();
    $('.home-icon').click(function(event) {
        event.preventDefault();
        window.location.href = '/'; // Redirect to the home page
    });
});
