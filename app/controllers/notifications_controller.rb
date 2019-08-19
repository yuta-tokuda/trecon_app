class NotificationsController < ApplicationController
  def confirm
    @notification = Notification.find(params[:id])
    @note = Note.find(params[:note_id])
    @notification.destroy
    redirect_to note_path(@note)
  end
end
