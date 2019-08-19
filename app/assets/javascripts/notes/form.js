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
  return $('#note-tags').tagit({
    singleField: true,
    availableTags: auto.all_tag_list
  });
});
