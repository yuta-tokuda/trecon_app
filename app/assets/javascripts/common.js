$(function() {
  // フラッシュメッセージをクリックで非表示にする
  $('.alert-success').click(function() {
    $(this).fadeOut();
  });

  // 吹き出しをクリックで表示・非表示にする。
  $('#notify-bell').click(function() {
    $('#balloon').toggle();
  });

  if ($('.unread-comment').length || $('.top-unread-comment').length) {
    $('.comment').mouseover(function() {
      $(this).prepend('<div class="unread-info">新しいコメントがあります。</div>');
    });
    $('.comment').mouseout(function() {
      $(this).children('.unread-info').remove();
    })
  }
  if ($('.unread-note').length || $('.top-unread-note').length) {
    $('.created').mouseover(function() {
      $(this).prepend('<div class="unread-info">新しい未読のノートです。</div>');
    });
    $('.created').mouseout(function() {
      $(this).children('.unread-info').remove();
    })
  }
});
