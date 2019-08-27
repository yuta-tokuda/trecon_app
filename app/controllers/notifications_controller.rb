class NotificationsController < ApplicationController
  def confirm
    notification = Notification.find(params[:notification_id])
    @note = notification.note
    unread_comment_id = current_user.passive_notifications.where(note_id: @note.id, kind: 'comment').last.comment_id if current_user.comment_notification_present?
    notification.destroy
    destroy_other_notifications
    redirect_to note_path(@note, comment_id: unread_comment_id)
  end

  private

  def destroy_other_notifications
    other_notifications = current_user.passive_notifications.where(note_id: @note.id, kind: 'comment')
    other_notifications&.destroy_all
  end
end
