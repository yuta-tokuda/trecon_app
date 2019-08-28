$(function() {
  $("a[href^='#comments']").click(function() {
    $('html, body').animate({
      scrollTop: $(document).height()
    }, 1000);
    return false;
  });

  jQuery('#toc').toc();

  //通知から未読コメントを参照したとき
  if ($('#unread_comment').length) {
    var unReadCommentId = $('#unread_comment').val();
    $(`#comment-${ unReadCommentId }`).before(unReadLineHtml);
    //ノートに直接遷移し、未読メッセージを参照したとき
  } else if ($('.comment-notification').size()) {
    var unReadComment = $('.comment-notification').last().attr('class').match(/comment-[0-9]{1,}/);
    var unReadCommentId = unReadComment[0].replace('comment-', '');
    $(`#comment-${ unReadCommentId }`).before(unReadLineHtml);
  }

  // １５秒後に未読の案内を消す
  setTimeout(function() {
    if ($(`.notifications > .comment-${ $('#unread_comment').val() }`)) {
      $('#unread_comment').remove();
      $('.unread-line').remove();
    };
  }, 15000);
});

var unReadLineHtml = `<div class='unread-line'>${ '-'.repeat(75) } 未読コメント ${ '-'.repeat(75) }</div>`
