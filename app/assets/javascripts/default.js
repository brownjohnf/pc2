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
  $('[rel=popover-top-focus]').popover({
    placement: 'top',
    trigger: 'focus'
    });
  $('[rel=popover-right]').popover({
    placement: 'right'
    });
  $('[rel=popover-right-focus]').popover({
    placement: 'right',
    trigger: 'focus'
    });
  $('[rel=popover-bottom]').popover({
    'placement':'bottom'
    });
  $('[rel=popover-left]').popover({
    'placement':'left'
    });
  $('[rel=popover-left-focus]').popover({
    placement: 'left',
    trigger: 'focus'
    });
  $('.tooltip-right-slow').tooltip({
    placement: 'right',
    delay: { show: 1000, hide:50 }
  });
  $('.tooltip-left').tooltip({
    placement: 'left',
  });
  $('.tooltip-left-slow').tooltip({
    placement: 'left',
    delay: { show: 1000, hide:50 }
  });
  $('.tooltip-left-focus-slow').tooltip({
    placement: 'left',
    delay: { show: 1000, hide:50 },
    trigger: 'focus'
  });
  $('.tooltip-bottom-focus-slow').tooltip({
    placement: 'bottom',
    delay: { show: 1000, hide:50 },
    trigger: 'focus'
  });

  // modals
  
  // add a slide effect to all modal-standard modals
  // init modal
  $('.modal-standard').addClass('fade').modal({
    show: false
  });

  $('#default_form_focus').focus();

});
