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
    if ($(this)[0].textContent.match(/...$/)) {
      $('#tag_name').val($(this).next().val());
    } else {
      $('#tag_name').val($(this)[0].textContent);
    }
    $('#note_search_submit').click();
  });
});
