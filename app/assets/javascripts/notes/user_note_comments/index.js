$(function() {
  $(document).on('click', '.edit-btn', function() {
    var id = $(this).prev('.comment_id').attr('value');
    $('.comment-' + id).toggle();
    $('.edit-comment-' + id).toggle();
    $('.edit-comment-' + id).children('textarea').val($(`.comment-${ id } > p`).text());
  });

  $(document).on('click', '.reply-btn', function() {
    var userFullName = $(this).prev().val();
    var passiveUserId = $(this).prev().prev().val();
    var replyCancelButton = "<div class='btn btn-danger reply-cancel-btn'>返信を取り消す</div>"
    $('#content_0').val(`To: ${ userFullName }さん\n`);
    if ($('#content_0').next().hasClass('passive-user-id')) {
      $('#content_0').next().attr('id', passiveUserId);
    } else {
      $('#content_0').after(`<input type='hidden' id='${ passiveUserId }' class="passive-user-id"></input>`)
      $('.preview-btn').after(replyCancelButton);
    }
  });

  $(document).on('click', '.reply-cancel-btn', function() {
    $('#content_0').val('');
    $('.passive-user-id').remove();
    $('.reply-cancel-btn').remove();
  });
});
