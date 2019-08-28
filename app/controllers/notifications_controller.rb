class NotificationsController < ApplicationController
  def confirm
    notification = Notification.find(params[:notification_id])
    @note = notification.note
    unread_comment_id = current_user.comment_notifications(@note).last&.comment_id
    notification.destroy
    destroy_other_notifications
    redirect_to note_path(@note, comment_id: unread_comment_id)
  end

  private

  def destroy_other_notifications
    current_user.comment_notifications(@note)&.destroy_all
  end
end
