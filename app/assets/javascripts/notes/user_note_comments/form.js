$(function() {
  $(document).on('click', '.preview-btn', function() {
    var commentId = $(this).prev().attr('id').replace('comment_submit_', '');
    $.ajax({
      url: '/common/preview',
      format: 'js',
      data: { content: $('#content_' + commentId)[0].value }
    });
  });

  $(document).on('click', '.create_comment', function() {
    var content = $('#content_' + $(this).attr('id').replace('comment_submit_', '')).val();
    if ($(this).prev().attr('id') != 'content_0') {
      var passiveUserId = $(this).prev().attr('id')
    }
    if (content == '') {
      alert('コメントを入力してください。');
      return false;
    } else {
      $.ajax({
        url: '/user_note_comments/create_comment',
        data: { note_id: $('#note_id').val(),
                content: content,
                passive_user_id: passiveUserId
              },
        dataType: 'json'
      })
      .done(function(data) {
        var html = buildHTML(data);
        $('.comments').append(html);
        $('.content').val('');
        $('.passive-user-id').remove();
        $('.reply-cancel-btn').remove();
      })
      .fail(function() {
        alert('エラーが発生しました。');
      });
    }
  });

  $(document).on('click', '.update_comment', function() {
    var commentId = $(this).attr('id').replace('comment_submit_', '');
    var content = $('#content_' + commentId).val();
    if (content == '') {
      alert('コメントを入力してください。');
      return false;
    } else {
      $.ajax({
        url: '/user_note_comments/update_comment',
        format: 'js',
        data: { note_id: $('#note_id').val(),
                comment_id: commentId,
                content: content
              },
        dataType: 'json'
      })
      .done(function(data) {
        var newComment = buildHTML(data);
        var oldComment = $(`.comment-${ commentId }`).parent().parent();
        $(oldComment).replaceWith(newComment);
      })
      .fail(function() {
        alert('エラーが発生しました。');
      });
    };
  });

  $(document).on('click', '.delete-btn', function() {
    var commentId = $(this).prev().prev('.comment_id').attr('value');
    if (confirm('削除してもよろしいですか？')) {
      $.ajax({
        url: '/user_note_comments/destroy_comment',
        format: 'js',
        data: { note_id: $('#note_id').val(),
                comment_id: commentId
              }
      })
      .done(function() {
        var deleteComment = $(`.comment-${ commentId }`).parent().parent();
        var deleteConfirm = `<div class='delete-confirm'>削除しました。</div>`
        $(deleteComment).replaceWith(deleteConfirm)
      })
      .fail(function() {
        alert('エラーが発生しました。すでに削除している可能性があります。');
        window.location.reload();
      });
    };
    return false;
  });
});

function buildHTML(data) {
  var commentWriteUser = data.comment_user_name == data.note_edit_user ? 'editor-comment' : 'reply-user-comment'
  var html = `<div class="comment-container">
                <div class=${ commentWriteUser }>
                  <div class="comment-header">
                    <div class="user-info">
                      <i class="far fa-user"></i><span class="user-name">${ data.comment_user_name }</span><span class="post-time">${ data.comment_date }</span>
                    </div>
                    <span class="custom-btn">
                      <input class="comment_id" type="hidden" value=${ data.comment_id }>
                      <div class="i far fa-edit edit-btn"></div><div class="delete_comment i far fa-trash-alt delete-btn"></div>
                    </span>
                  </div>

                  <div class="comment comment-${ data.comment_id }">
                    <p>${ data.content }</p>
                  </div>

                  <div class="edit-comment edit-comment-${ data.comment_id }">
                    <textarea class="form-control content" placeholder="コメントを入力してください" id="content_${ data.comment_id }" name="content[${ data.content }]">
                    </textarea>
                    <div class="btn btn-success float-right update_comment" id="comment_submit_${ data.comment_id }">更新</div>
                    <div class="btn preview-btn">プレビュー</div>
                  </div>
                </div>
              </div>`
  return html;
}
