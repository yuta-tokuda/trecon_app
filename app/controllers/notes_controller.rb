class NotesController < ApplicationController
  before_action :user_not_authorized

  def index
    @notes = paging(search_result, (params[:per_page] || 15))
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(permit_params.merge(created_by_user_id: current_user.id))
    @note.save!
    flash[:notice] = 'ノートを登録しました。'
    create_note_notification if @note.public_flag
    redirect_to action: :show, id: @note.id
  rescue ActiveRecord::RecordInvalid
    render :new
  end

  def edit
    @note = Note.find(params[:id])
    only_current_user
  end

  def update
    @note = Note.find(params[:id])
    @note.update!(permit_params)
    flash[:notice] = 'ノートを更新しました。'
    create_note_notification if @note.public_flag_change?
    redirect_to action: :show, id: @note.id
  rescue ActiveRecord::RecordInvalid
    render :edit
  end

  def destroy
    @note = Note.find(params[:id])
    only_current_user
    @note.destroy
    flash[:notice] = 'ノートを削除しました。'
    redirect_to action: :index
  rescue ActiveRecord::RecordInvalid
    render :edit
  end

  def show
    @note = Note.find(params[:id])
    @comment = comments.build
    comments
    destroy_note_notification
    viewable_not_authorized
  end

  # お気に入り追加
  def add_favorite
    note = Note.find(params[:note_id])

    if note.favorite_note?(current_user.id)
      flash[:error] = 'すでにお気に入りに追加されています。'
    else
      favorite_note = current_user.favorite_notes.new(note_id: note.id)
      favorite_note.save!
      flash[:notice] = 'お気に入りに追加しました。'
    end
    redirect_to action: :show, id: note.id
  end

  # お気に入り解除
  def release_favorite
    note = Note.find(params[:note_id])

    if note.favorite_note?(current_user.id)
      current_user.favorite_notes.find_by(note_id: note.id).destroy!
      flash[:notice] = 'お気に入りを解除しました。'
    else
      flash[:error] = 'お気に入りにないため解除できません。'
    end
    redirect_to action: :show, id: note.id
  end

  private

  def permit_params
    params.require(:note).permit(:title, :content, :public_flag)
  end

  def only_current_user
    return if current_user == @note.user

    flash[:error] = '編集は登録者のみ可能です。'
    redirect_to action: :show, id: @note.id
  end

  def viewable_not_authorized
    return if @note.viewable_note?(current_user.id)

    flash[:error] = '閲覧不可のノートです'
    redirect_to action: :index
  end

  def search_result
    notes = Note.current_viewable_notes(current_user.id)
                .includes(:user)
    notes = notes.my_notes(current_user.id) if ActiveRecord::Type::Boolean.new.cast(params[:my_note_flag])
    notes = notes.where(id: current_user.favorite_notes.map(&:note_id)) if ActiveRecord::Type::Boolean.new.cast(params[:favorite_note_flag])
    @query = notes.ransack(params[:q])
    ret = @query.result.order(created_at: :DESC)
    ret
  end

  def comments
    @comments ||= @note.comments.includes(:reply_user).order(:id)
  end

  def create_note_notification
    user_ids = User.other_user_ids(current_user.id)
    user_ids.each do |user_id|
      @note.notifications.create(active_user_id: current_user.id, passive_user_id: user_id, kind: 'note')
    end
  end

  def destroy_note_notification
    note_notification = current_user.passive_notifications.find_by(note_id: @note.id, kind: 'note')
    note_notification&.destroy
  end
end
