$('.preview-btn').click(function() {
  $.ajax({
    url: '/common/preview',
    format: 'js',
    data: { content: $('#' + this.parentNode.id + '> .content')[0].value }
  });
});
