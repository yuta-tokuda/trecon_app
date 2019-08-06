$(function() {
  $("a[href^='#comments']").click(function() {
    $('html, body').animate({
      scrollTop: $(document).height()
    },1000);
    return false;
  });

  jQuery('#toc').toc();
});
