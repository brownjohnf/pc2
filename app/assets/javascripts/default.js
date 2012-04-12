$(function(){

  // fix sub nav on scroll
  var $win = $(window)
    , $nav = $('.subnav')
    , navTop = $('.subnav').length && $('.subnav').offset().top - 40
    , isFixed = 0
  
  processScroll()
  
  $win.on('scroll', processScroll)
  
  function processScroll() {
    var i, scrollTop = $win.scrollTop()
    if (scrollTop >= navTop && !isFixed) {
      isFixed = 1
      $nav.addClass('subnav-fixed')
    } else if (scrollTop <= navTop && isFixed) {
      isFixed = 0
      $nav.removeClass('subnav-fixed')
    }
  }
  
  $('.dyn-datatable').dataTable();
  
  $('.accordion').collapse();
  $('.carousel').carousel();
  $('[rel=popover-top]').popover({
    'placement':'top'
    });
  $('[rel=popover-right]').popover({
    placement: 'right'
    });
  $('[rel=popover-bottom]').popover({
    'placement':'bottom'
    });
  $('.tooltip-right-slow').tooltip({
    placement: 'right',
    delay: { show: 1000, hide:50 }
  });
  $('.tooltip-left-slow').tooltip({
    placement: 'left',
    delay: { show: 1000, hide:50 }
  });

});
