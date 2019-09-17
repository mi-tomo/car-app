$(document).on('turbolinks:load', function() {
  $(".loadingWrap").hide();
  $(document).ready(function(){
    $('.btn--block').click(function(){
      $(".loadingWrap").fadeIn();
    })
  });
$(window).load(function(){
	$(".loadingWrap").fadeOut();
});

});
