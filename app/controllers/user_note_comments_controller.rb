class UserNoteCommentsController < ApplicationController
  before_action :user_not_authorized

  def create_comment
    @note = Note.find(params[:note_id])
    @comment = @note.comments.new(permit_params)
    @passive_user = User.find_by(id: params[:passive_user_id])
    @comment.save
    create_comment_notification
    respond_to do |format|
      format.html { redirect_to note_path(@note) }
      format.json
    end
  end

  def update_comment
    @note = Note.find(params[:note_id])
    @comment = @note.comments.find(params[:comment_id])
    @comment.update(permit_params)
    respond_to do |format|
      format.html { redirect_to note_path(@note) }
      format.json
    end
  end

  def destroy_comment
    @note = Note.find(params[:note_id])
    comment = @note.comments.find(params[:comment_id])
    comment.destroy
  end

  private

  def permit_params
    params.permit(:content).merge(reply_user_id: current_user.id, editor_id: @note.created_by_user_id)
  end

  def create_comment_notification
    if @passive_user
      @comment.notifications.create(active_user_id: current_user.id, passive_user_id: @passive_user.id, note_id: @note.id, kind: 'comment')
    elsif !@note.created_user?(current_user.id)
      @comment.notifications.create(active_user_id: current_user.id, passive_user_id: @note.created_by_user_id, note_id: @note.id, kind: 'comment')
    end
  end
end
