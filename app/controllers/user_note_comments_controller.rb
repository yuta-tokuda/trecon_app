class UserNoteCommentsController < ApplicationController
  before_action :user_not_authorized

  def create_comment
    @note = Note.find(params[:note_id])
    @comment = comments.new(permit_params)
    @comment.save
    create_comment_notification
    respond_to do |format|
      format.html { redirect_to note_path(@note) }
      format.json
    end
  end

  def update_comment
    @note = Note.find(params[:note_id])
    @comment = comments.find(params[:comment_id])
    @comment.update(permit_params)
    respond_to do |format|
      format.html { redirect_to note_path(@note) }
      format.json
    end
  end

  def destroy_comment
    @note = Note.find(params[:note_id])
    comment = comments.find(params[:comment_id])
    comment.destroy
  end

  private

  def permit_params
    params.permit(:content).merge(reply_user_id: current_user.id, editor_id: @note.created_by_user_id)
  end

  def comments
    @comments ||= @note.comments
  end

  def comment_notifications
    @comment_notifications ||= @comment.notifications
  end

  def create_comment_notification
    if @note.comment_before_posting.present?
      comment_notifications.create(active_user_id: current_user.id, passive_user_id: @note.comment_before_posting.reply_user_id, kind: 'comment') if @note.comment_before_posting.reply_user_id != current_user.id
    elsif !@note.created_user?(current_user.id)
      comment_notifications.create(active_user_id: current_user.id, passive_user_id: @note.created_by_user_id, kind: 'comment')
    end
  end
end
