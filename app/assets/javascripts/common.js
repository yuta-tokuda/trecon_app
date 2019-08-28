$(function() {
  // フラッシュメッセージをクリックで非表示にする
  $('.alert-success').click(function() {
    $(this).fadeOut();
  });

  // 吹き出しをクリックで表示・非表示にする。
  $('#notify-bell').click(function() {
    $('#balloon').toggle();
  });

  if ($('.unread-comment').length) {
    $('.fa-exclamation-circle').mouseover(function() {
      $(this).prepend('<div class="unread-info">新しいコメントがあります。</div>');
    });
    $('.fa-exclamation-circle').mouseout(function() {
      $(this).children('.unread-info').remove();
    })
  }
});
