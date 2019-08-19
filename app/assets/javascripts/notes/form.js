$(function() {
  $('.preview-btn').click(function() {
    $.ajax({
      url: '/common/preview',
      format: 'js',
      data: { content: $('#markdown_content').val() }
    });
  });

});

$(document).on('ready page:load', function() {
  $('#note-tags').tagit();
  return {
    singleField: true,
    availableTags: auto.all_tag_list
  };
});
