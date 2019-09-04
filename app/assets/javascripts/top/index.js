$(function() {
  $("#top .set_page").infinitescroll({
    loading: {
      img: "http://www.mytreedb.com/uploads/mytreedb/loader/ajax_loader_blue_48.gif",
      msgText: "ロード中..."
    },
    navSelector: ".pagination",
    nextSelector: ".pagination a[rel=next]",
    itemSelector: "#top tr.set_page"
  });
});
