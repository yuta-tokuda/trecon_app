$(function() {
  $('#questionnaire_my_questionnaire_flag').on('change', function(){
    $('#my_questionnaire_flag').val(this.checked);
    $('#questionnaire_search_submit').click();
  });
});
