$(function() {
  $('.preview-btn').click(function() {
    var comment_id = $(this).prev().attr('id').replace('comment_submit_', '');
    $.ajax({
      url: '/common/preview',
      format: 'js',
      data: { content: $('#content_' + comment_id)[0].value }
    });
  });

  function buildHTML(data) {
    var comment_write_user = data.comment_user_name == data.note_edit_user ? 'editor-comment' : 'reply-user-comment'
    var html = `<div class="comment-container">
                  <div class=${ comment_write_user }>
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

  $(document).on('click', '.create_comment', function() {
    var content = $('#content_' + $(this).attr('id').replace('comment_submit_', '')).val();
    if(content == '') {
      alert('コメントを入力してください。');
      return false;
    } else {
      $.ajax({
        url: '/user_note_comments/create_comment',
        data: { note_id: $('#note_id').val(),
                content: content
              },
        dataType: 'json'
      })
      .done(function(data) {
        var html = buildHTML(data);
        $('.comments').append(html);
        $('.content').val('');
      })
      .fail(function(data) {
        alert('エラーが発生しました。')
      });
    }
  });

  $(document).on('click', '.update_comment', function() {
    var comment_id = $(this).attr('id').replace('comment_submit_', '');
    var content = $('#content_' + comment_id).val();
    if(content == '') {
      alert('コメントを入力してください。');
      return false;
    } else {
      $.ajax({
        url: '/user_note_comments/update_comment',
        format: 'js',
        data: { note_id: $('#note_id').val(),
                comment_id: comment_id,
                content: content
              }
      })
      .done(function(data) {
        var new_comment = buildHTML(data);
        var old_comment = $(`.comment-${ comment_id }`).parent().parent();
        $(old_comment).replaceWith(new_comment);
      });
    };
  });

  $(document).on('click', '.delete-btn', function() {
    var comment_id = $(this).prev().prev('.comment_id').attr('value');
    alert('削除してもよろしいですか？');
    $.ajax({
      url: '/user_note_comments/destroy_comment',
      format: 'js',
      data: { note_id: $('#note_id').val(),
              comment_id: comment_id
            },
      success: function() {
        var delete_comment = $(`.comment-${ comment_id }`).parent().parent();
        var delete_confirm = `<div class='delete-confirm'>削除しました。</div>`
        $(delete_comment).replaceWith(delete_confirm)
      }
    });
  });
});
