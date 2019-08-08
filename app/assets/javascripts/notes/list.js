$(function() {
  $('#note_my_note_flag').on('change', function(){
    $('#my_note_flag').val(this.checked);
    $('#note_search_submit').click();
  });

  $('#note_favorite_note_flag').on('change', function(){
    $('#favorite_note_flag').val(this.checked);
    $('#note_search_submit').click();
  });

  $('.trunk8').trunk8({
    lines: 1,
    tooltip: false
  });
});

/* handle browser resize too */
$(window).resize(function (event) {
  $('.trunk8').trunk8();
});
