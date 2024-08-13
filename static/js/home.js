$(document).ready(function () {
    function toggleNavLinks(visible) {
        if (visible) {
            $('.nav-link-icon').each(function (index) {
                var delay = index * 200; // 0.2 seconds interval
                $(this).delay(delay).animate({
                    opacity: 1,
                    transform: 'scale(1)'
                }, 200); // 0.2 seconds for appearance animation
            });
        } else {
            $('.nav-link-icon').each(function (index) {
                $(this).delay(index * 200).animate({
                    opacity: 0,
                    transform: 'scale(0)'
                }, 200); // 0.2 seconds for disappearance animation
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
        var radius = 200; // Distance from the center of the big circle

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

    $('.nav-link-icon').click(function (event) {
        event.preventDefault();
        var selectedCategory = $(this).data('category');
        // Redirect to seed.html with the category as a query parameter
        window.location.href = '/seeds/?category=' + encodeURIComponent(selectedCategory);
    });
});
