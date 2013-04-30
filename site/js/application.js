$(window).load(function() {
  
  if($('.header-content .nav').length) {
    $('.header-content .nav li').each(function(){
      $(this).hover(function() {
        $(this).children('.sub-menu').show();
      }, function() {
        $(this).children('.sub-menu').hide();
      });
    });
  }
  
});