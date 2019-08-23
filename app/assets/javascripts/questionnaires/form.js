$(function() {
  $('.remove_fields').each(function(index, elem){
    // 先頭2項目は削除されないようにしておく
    $(elem).remove();

    if (index == 1) {
      return false;
    };
  });

  // バリデーション警告
  $('.btn-success').click(function() {
    if ($('.title-form').val() == '') {
      alert('タイトルを入力してください');
      return false;
    } else if (item_valid_check() != '') {
      alert('未入力の項目があります');
      return false;
    };
  });
});


function item_valid_check() {
  empty_items = '';

  $('.item-form').each(function(_, elem){
    if ($(elem).val() == '') {
      empty_items = 'true'
      return false;
    };
  });

  return empty_items
};
