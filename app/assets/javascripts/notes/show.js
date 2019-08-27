$(function() {
  $("a[href^='#comments']").click(function() {
    $('html, body').animate({
      scrollTop: $(document).height()
    },1000);
    return false;
  });

  jQuery('#toc').toc();

  //ノートに直接遷移し、未読メッセージを参照したとき
  if ($('#unread_comment').length) {
    var unReadCommentId = $('#unread_comment').val();
    $(`#comment-${ unReadCommentId }`).before(unReadHtml);
    //通知から未読コメントを参照したとき
  } else if ($('.notifications > .comment-notification').size()) {
    var unReadCommentId = $('.notifications > .comment-notification').last().attr('class').match(/comment-[0-9]{1,}/);
    $(`#${ unReadCommentId[0] }`).before(unReadHtml);
  }

  // １５秒後に未読の案内を消す
  setTimeout(function() {
    if ($(`.notifications > .comment-${ $('#unread_comment').val() }`)) {
      $('#unread_comment').remove();
      $('.unread-line').remove();
    };
  }, 15000);
});

var unReadHtml = `<div class='unread-line'>${ '-'.repeat(74) } 未読メッセージ ${ '-'.repeat(74) }</div>`
