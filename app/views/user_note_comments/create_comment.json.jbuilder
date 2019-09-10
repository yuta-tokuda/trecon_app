json.note_edit_user @note.created_by_user.full_name
json.comment_id @comment.id
json.comment_user_name @comment.reply_user.full_name
json.comment_date l @comment.created_at
json.content @comment.content
