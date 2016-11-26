//= require jquery
//= require tether/dist/js/tether.min
//= require bootstrap/dist/js/bootstrap.min
//= require lodash/dist/lodash.core
//= require map



$(function() {
  $('.dropdown-toggle').dropdown();

  $('ul.nav li.dropdown').hover(function() {
    if(+$('body').width() > 992) {
      $(this).addClass('active');
    }
  }, function() {
    if(+$('body').width() > 992) {
      $(this).removeClass('active')
    }
  });
});
