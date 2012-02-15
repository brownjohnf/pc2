// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

/*
$(function() {
   $('#slider1').anythingSlider({
	  resizeContents: true,
	  buildArrows: false,
	  buildNavigation: false,
	  delay: 2000,
	  animation: 600,
	  easing: "swing",
	  buildStartStop: false
   });
   $('#slider1').data('AnythingSlider').startStop(true);
});*/

$(function(){
 $('#slider1')
  .anythingSlider({
   buildNavigation : false,
   startText	: 'start',
   toggleArrows	: true,
   autoPlay	: true,
   theme          : 'minimalist-round',
   delay : 5000
  })
  // target all images inside the current slider
  // replace with 'img.someclass' to target specific images
  .find('.panel:not(.cloned) .slide img') // ignore the cloned panels
   .attr('rel','group')            // add all slider images to a colorbox group
   .colorbox({
     href: function(){ return $(this).attr('src'); },
     // use $(this).attr('title') for specific image captions
     title: 'Press escape to close',
     rel: 'group'
   });
});
