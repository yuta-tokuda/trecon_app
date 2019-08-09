class UserNoteCommentsController < ApplicationController
  before_action :user_not_authorized

  def create_comment
    @note = Note.find(params[:note_id])
    @comment = comments.new(permit_params)
    @comment.save
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
end
