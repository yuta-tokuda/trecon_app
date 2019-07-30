$(function() {
  $("a[href^='#comments']").click(function() {
    $('html, body').animate({
      scrollTop: $(document).height()
    },1000);
    return false;
  });

  jQuery('#toc').toc();

  $(function() {
    $('.edit-btn').click(function() {
      var id = $(this).children('.comment-id').attr('value');
      $('.comment-' + id).toggle();
      $('.edit-comment-' + id).toggle();
    })
  });
});
