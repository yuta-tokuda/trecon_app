$(function() {
  $('.preview-btn').click(function() {
    var comment_id = $(this).prev().attr('id').replace('comment_submit_', '');
    $.ajax({
      url: '/common/preview',
      format: 'js',
      data: { content: $('#content_' + comment_id)[0].value }
    });
  });

  function form_blank (submit_button) {
    if ($(submit_button).prev('.content').val() == '') {
      alert('コメントを入力してください。');
      return false;
    };
  };

  $('.create_comment').click(function() {
    form_blank(this);
    var content = $('#content_' + $(this).attr('id').replace('comment_submit_', '')).val();
    $.ajax({
      url: '/user_note_comments/create_comment',
      format: 'js',
      data: { note_id: $('#note_id').val(), content: content }
    });
  });

  $('.update_comment').click(function() {
    form_blank(this);
    var comment_id = $(this).attr('id').replace('comment_submit_', '');
    var content = $('#content_' + comment_id).val();
    $.ajax({
      url: '/user_note_comments/update_comment',
      format: 'js',
      data: { note_id: $('#note_id').val(), comment_id: comment_id, content: content }
    });
  });

  $('.delete_comment').click(function() {
    var comment_id = $(this).prev().prev('.comment_id').attr('value');
    alert('削除してもよろしいですか？');
    $.ajax({
      url: '/user_note_comments/destroy_comment',
      format: 'js',
      data: { note_id: $('#note_id').val(), comment_id: comment_id }
    });
  });
});
