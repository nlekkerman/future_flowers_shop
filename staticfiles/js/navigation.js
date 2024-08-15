$(document).ready(function () {
    function toggleNavLinks(visible) {
        if (visible) {
            // Resize the menuIcon when nav-link-icons are visible
            $('#menuIcon').stop().animate({
                width: '80px', // Decrease width
                height: '80px' // Decrease height
            }, 500); // Duration for resizing animation

            $('.menu-icon-span').stop().animate({
                opacity: 0.5 // Reduce opacity of the text inside menuIcon
            }, 1000);

            $('.nav-link-icon').each(function (index) {
                var delay = index * 200; // 0.2 seconds interval
                $(this).stop().css({
                    display: 'flex', // Ensure they are displayed
                    pointerEvents: 'auto' // Allow interactions
                }).delay(delay).animate({
                    opacity: 1,
                    transform: 'scale(1)'
                }, 200); // 0.2 seconds for appearance animation
            });
        } else {
            // Reset menuIcon size when nav-link-icons are hidden
            $('#menuIcon').stop().animate({
                width: '100px', // Original width
                height: '100px' // Original height
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
        var numSmallCircles = $('.nav-link-icon').length;
        var angleStep = 360 / numSmallCircles;
        var radius = 100; // Distance from the center of the big circle

        $('.nav-link-icon').each(function (index) {
            var angle = angleStep * index;
            var radians = angle * (Math.PI / 180);
            var x = radius * Math.cos(radians);
            var y = radius * Math.sin(radians);
            $(this).css({
                top: 'calc(50% + ' + y + 'px)',
                left: 'calc(50% + ' + x + 'px)',
                transform: 'translate(-50%, -50%)'
            });
        });
    }

    positionNavLinks();
    $('.home-icon').click(function(event) {
        event.preventDefault(); // Prevent default link behavior
        window.location.href = '/'; // Redirect to the home page
    });

    // Handle other category links
    $('.nav-link-click').click(function(event) {
        // Check if the clicked element has a data-category attribute
        let selectedCategory = $(this).data('category');
        if (selectedCategory) {
            event.preventDefault(); // Prevent default link behavior
            // Redirect to the seeds page with the category as a query parameter
            window.location.href = '/seeds/?category=' + encodeURIComponent(selectedCategory);
        }
    });
});
