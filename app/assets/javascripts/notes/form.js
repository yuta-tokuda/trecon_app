$(function() {
  $('.preview-btn').click(function() {
    $.ajax({
      url: '/common/preview',
      format: 'js',
      data: { content: $('#markdown_content').val() }
    });
  });
});
