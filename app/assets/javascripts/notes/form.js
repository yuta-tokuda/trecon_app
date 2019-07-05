$(function() {
  $('.note-preview-btn').click(function(){
    $.ajax({
      url: '/notes/preview',
      format: 'js',
      data: { content: $('#note_content').val() }
    });
  });
});
