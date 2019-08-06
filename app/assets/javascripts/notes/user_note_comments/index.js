$(function() {
  $('.edit-btn').click(function() {
    var id = $(this).prev('.comment_id').attr('value');
    $('.comment-' + id).toggle();
    $('.edit-comment-' + id).toggle();
    $('.edit-comment-' + id).children('textarea').val($(`.comment-${ id } p`).text());
  })
});
