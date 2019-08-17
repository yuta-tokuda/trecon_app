class QuestionnairesController < ApplicationController
  before_action :user_not_authorized

  def index; end

  def new
    @questionnaire = Questionnaire.new
    2.times { @questionnaire.items.build }
  end

  def create
    @questionnaire = Questionnaire.new(permit_params.merge(created_by_user_id: current_user.id))
    @questionnaire.save!
    flash[:notice] = 'アンケートを作成しました'
    redirect_to action: :index
  rescue ActiveRecord::RecordInvalid
    render :new
  end

  def edit
    @questionnaire = Questionnaire.find(params[:id])
    only_current_user
  end

  def update
    @questionnaire = Questionnaire.find(params[:id])
    only_current_user
    @questionnaire.update!(permit_params)
    flash[:notice] = 'アンケートを更新しました。'
    redirect_to action: :index
  rescue ActiveRecord::RecordInvalid
    render :edit
  end

  def destroy
    @questionnaire = Questionnaire.find(params[:id])
    only_current_user
    @questionnaire.destroy
    flash[:notice] = 'アンケートを削除しました。'
    redirect_to action: :index
  rescue ActiveRecord::RecordInvalid
    render :edit
  end

  private

  def permit_params
    params.require(:questionnaire).permit(:title, items_attributes: %i[id item _destroy])
  end

  def only_current_user
    return if current_user == @questionnaire.created_user

    flash[:error] = '編集は作成者のみ可能です。'
    redirect_to action: :index
  end
end
