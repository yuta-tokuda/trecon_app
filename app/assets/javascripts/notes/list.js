$(function() {
  $('#note_my_note_flag').on('change', function(){
    $('#my_note_flag').val(this.checked);
    $('#note_search_submit').click();
  });

  $('#note_favorite_note_flag').on('change', function(){
    $('#favorite_note_flag').val(this.checked);
    $('#note_search_submit').click();
  });

  $('.tag').click(function() {
    $('#tag_name').val($(this).next().val());
    $('#note_search_submit').click();
  });
});
