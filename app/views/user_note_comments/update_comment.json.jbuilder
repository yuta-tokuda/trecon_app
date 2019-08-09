json.note_edit_user @note.user.full_name
json.comment_id @comment.id
json.comment_user_name @comment.reply_user.full_name
json.comment_date @comment.updated_at.strftime('%Y/%m/%d %H:%M')
json.content @comment.content
