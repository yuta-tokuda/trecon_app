$(function() {
  // フラッシュメッセージをクリックで非表示にする
  $('.alert-success').click(function() {
    $(this).fadeOut();
  });
});
