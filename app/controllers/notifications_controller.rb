class NotificationsController < ApplicationController
  def confirm
    notification = Notification.find_by(id: params[:notification_id])
    unread_comment = UserNoteComment.find_by(id: params[:unread_comment_id])
    @note = unread_comment&.note || notification.note
    notification&.destroy
    destroy_other_notifications
    redirect_to note_path(@note, comment_id: unread_comment&.id)
  end

  private

  def destroy_other_notifications
    current_user.comment_notifications(@note)&.destroy_all
  end
end
