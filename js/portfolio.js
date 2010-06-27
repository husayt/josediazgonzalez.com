$(function () {

	var containerTop = $('#main-container').offset().top;

	// Full View
	$('#full-view').click(function () {
		var y = $(window).scrollTop();
		if ($('#project-list').hasClass('thumbs') && (y > containerTop)) {
			$('html, body').animate({
				scrollTop: containerTop-50
			}, {
				duration: 800,
				easing: 'easeOutExpo'
			});
		}
		$('#project-list').removeClass('thumbs');
		containerBottom = getContainerBottom();
		return false;
	})
	// Thumbnail View
	$('#thumb-view').click(function () {
		var y = $(window).scrollTop();
		if (!$('#project-list').hasClass('thumbs') && (y > containerTop)) {
			$('html, body').animate({
				scrollTop: containerTop-50
			}, {
				duration: 800,
				easing: 'easeOutExpo'
			});
		}
		$('#project-list').addClass('thumbs');
		containerBottom = getContainerBottom();
		return false;
	})

	function getContainerBottom() {
		return $('#main-container').offset().top + $('#main-container').outerHeight();
	}

	// Sliding track
	// I'm no pro, so if you have a better way of doing this kindly share <3
	
	var msie6 = $.browser.msie && $.browser.version < 7;
	if (($('#sliding-container').length) && !msie6) {

		var slidingBox = $('#sliding-container');
		var top = slidingBox.offset().top;
		containerBottom = getContainerBottom();

		$(window).scroll(function () {
			var y = $(window).scrollTop();
			if (y >= top) {
				if (y >= (containerBottom - slidingBox.outerHeight())) {
					slidingBox.removeClass('fixed');
					slidingBox.addClass('pinned');
				} else if (y <= (containerBottom - slidingBox.outerHeight())) {
					slidingBox.addClass('fixed');
					slidingBox.removeClass('pinned');
				}
			} else {
				slidingBox.removeClass('fixed');
				slidingBox.removeClass('pinned');
			}
		});
	}
	
	// Project Page Slideshow
	if ($('#project-slider').length) {
		$('#project-slider ul.slides').cycle({
			fx: 'fade',
			speed: 'fast',
			timeout: 3000
		});
	}

	$('#project-slider').mouseenter(function () {
		$(this).find('a#lightbox').stop().animate({
			opacity: 0.5
		}, 300)
	}).mouseleave(function () {
		$(this).find('a#lightbox').stop().animate({
			opacity: 0
		}, 300)
	});

	$("#lightbox").click(function (a) {
		a.preventDefault();

		var slideImages = [];
		$('#project-slider .slides').find('li img').each(function (index) {
			slideImages[index] = $(this).attr('src');
		});

		$.fancybox(slideImages, {
			'padding': 0,
			'transitionIn': 'elastic',
			'transitionOut': 'elastic',
			'easingIn': 'easeOutBack',
			'easingOut': 'easeInBack',
			'type': 'image',
			'overlayOpacity': 0.5
		});
	});

}); // End Document Ready