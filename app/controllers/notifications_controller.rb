class NotificationsController < ApplicationController
  def confirm
    notification = Notification.find(params[:id])
    @note = notification.note
    notification.destroy
    redirect_to note_path(@note)
  end
end
