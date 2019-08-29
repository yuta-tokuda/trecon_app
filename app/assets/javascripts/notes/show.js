$(function() {
  $("a[href^='#comments']").click(function() {
    $('html, body').animate({
      scrollTop: $(document).height()
    }, 1000);
    return false;
  });

  jQuery('#toc').toc();

  //通知から未読コメントを参照したとき
  if (location.href.match(/#comment-/)) {
    var unReadCommentId = location.href.match(/#comment-[0-9]{1,}/)[0].replace('#comment-', '')
    $(`#comment-${ unReadCommentId }`).before(unReadLineHtml);
  }

  // １５秒後に未読の案内を消す
  setTimeout(function() {
    if ($(`.notifications > .comment-${ $('#unread_comment').val() }`)) {
      $('.unread-line').remove();
    };
  }, 15000);
});

var unReadLineHtml = `<div class='unread-line'>${ '-'.repeat(75) } 未読コメント ${ '-'.repeat(75) }</div>`
