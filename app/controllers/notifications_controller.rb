class NotificationsController < ApplicationController
  def confirm
    Notification.find_by(id: params[:notification_id])&.destroy
    unread_comment = UserNoteComment.find_by(id: params[:unread_comment_id])
    note = Note.find_by(id: params[:note_id])
    destroy_other_notifications(note)
    unread_comment ? redirect_to(note_path(note, anchor: "comment-#{ unread_comment.id }")) : redirect_to(note_path(note))
  end

  private

  def destroy_other_notifications(note)
    current_user.comment_notifications(note)&.destroy_all
  end
end
