$(function() {
  $("a[href^='#comments']").click(function() {
    $('html, body').animate({
      scrollTop: $(document).height()
    }, 1000);
    return false;
  });

  jQuery('#toc').toc();

  //コメントのアンカーからidを取得し、未読案内を差し込む。(アンカーがコメントである前提なので他にアンカーを適用させる場合は注意。)
  if (location.hash) {
    var unReadCommentId = location.hash.replace('#comment-', '')
    $(`#comment-${ unReadCommentId }`).before(unReadLineHtml);
  }

  // １５秒後に未読の案内を消す
  setTimeout(function() {
    $('.unread-line').remove();
  }, 15000);
});

var unReadLineHtml = `<div class='unread-line'>${ '-'.repeat(75) } 未読コメント ${ '-'.repeat(75) }</div>`
