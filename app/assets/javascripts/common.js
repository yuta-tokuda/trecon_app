$(function() {
  // フラッシュメッセージをクリックで非表示にする
  $('.alert-success').click(function() {
    $(this).fadeOut();
  });

  // 吹き出しをクリックで表示・非表示にする。
  $('#notify-bell').click(function() {
    $('#balloon').toggle();
  });

  if ($('#notification-count').val() >= 1) {
    $('.badge').addClass('new');
  } 
});
