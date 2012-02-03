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
   toggleControls : true,
   theme          : 'metallic',
   navigationFormatter : function(i, panel){ // add thumbnails as navigation links
    return '<img src="demos/images/th-slide-' + ['civil-1', 'env-1', 'civil-2', 'env-2'][i - 1] + '.jpg">';
   }
  })
  // target all images inside the current slider
  // replace with 'img.someclass' to target specific images
  .find('.panel:not(.cloned) .slide') // ignore the cloned panels
   .attr('rel','group')            // add all slider images to a colorbox group
   .colorbox({
     width: '90%',
     height: '90%',
     href: function(){ return $(this).css('background-image'); },
     // use $(this).attr('title') for specific image captions
     title: 'Press escape to close',
     rel: 'group'
   });
});
