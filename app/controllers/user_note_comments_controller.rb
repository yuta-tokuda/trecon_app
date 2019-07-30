class UserNoteCommentsController < ApplicationController
  before_action :user_not_authorized

  def create
    @note = Note.find(params[:note_id])
    comment = comments.new(permit_params)
    if comment.save
      flash[:notice] = 'コメントを投稿しました。'
    else
      flash[:danger] = 'コメントを記入してください。'
    end
    redirect_to @note
  end

  def update
    @note = Note.find(params[:note_id])
    comment = comments.find(params[:comment_id])
    if current_user.comment_reply_user?(comment) && content_valid?
      flash[:notice] = 'コメントを更新しました。'
      comment.update(permit_params)
    elsif !content_valid?
      flash[:danger] = 'コメントを入力してください。'
    end
    redirect_to note_path(@note)
  end

  def destroy
    @note = Note.find(params[:note_id])
    comment = comments.find(params[:comment_id])
    if current_user.comment_reply_user?(comment)
      flash[:notice] = 'コメントを削除しました。'
      comment.destroy
    else
      flash[:danger] = 'コメント投稿者のみ有効です。'
    end
    redirect_to note_path(@note)
  end

  private

  def permit_params
    params.require(:user_note_comment).permit(:content).merge(reply_user_id: current_user.id, editor_id: @note.created_by_user_id)
  end

  def content_valid?
    params[:user_note_comment][:content].present?
  end

  def comments
    @comments ||= @note.comments
  end
end
