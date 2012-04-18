$(function(){

  /*********************************************/
  /* code from bootstrap doc pages for a 'sticky'
     subnav bar */

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

  /**********************************************/
  /* datatables */

  $('.dyn-datatable').dataTable();

  /*********************************************/
  /* bootstrap accordion */

  $('.accordion').collapse();
  
  /*********************************************/
  /* bootstrap carousel */

  $('.carousel').carousel();
  
  /*********************************************/
  /* bootstrap popovers */

  // top
  $('[rel=popover-top]').popover({
    'placement':'top'
    });

  // top focus
  $('[rel=popover-top-focus]').popover({
    placement: 'top',
    trigger: 'focus'
    });

  // right
  $('[rel=popover-right]').popover({
    placement: 'right'
    });

  // right focus
  $('[rel=popover-right-focus]').popover({
    placement: 'right',
    trigger: 'focus'
    });

  // bottom
  $('[rel=popover-bottom]').popover({
    'placement':'bottom'
    });

  // left
  $('[rel=popover-left]').popover({
    'placement':'left'
    });

  // left focus
  $('[rel=popover-left-focus]').popover({
    placement: 'left',
    trigger: 'focus'
    });

  /*********************************************/
  /* bootstrap tooltips */

  // right slow
  $('.tooltip-right-slow').tooltip({
    placement: 'right',
    delay: { show: 1000, hide:50 }
  });

  // left
  $('.tooltip-left').tooltip({
    placement: 'left',
  });

  // left slow
  $('.tooltip-left-slow').tooltip({
    placement: 'left',
    delay: { show: 1000, hide:50 }
  });

  // left focus slow
  $('.tooltip-left-focus-slow').tooltip({
    placement: 'left',
    delay: { show: 1000, hide:50 },
    trigger: 'focus'
  });

  // bottom focus slow
  $('.tooltip-bottom-focus-slow').tooltip({
    placement: 'bottom',
    delay: { show: 1000, hide:50 },
    trigger: 'focus'
  });

  /*********************************************/
  /* bootstrap modals */  
  
  // modal-standard modals
  $('.modal-standard')
    // add slide effect
    .addClass('fade')
    // init modal
    .modal({
      show: false
    });

  /*********************************************/
  /* assorted other js stuff */

  // sets default form focus based on input ID
  $('#default_form_focus').focus();

});
