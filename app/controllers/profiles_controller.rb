class ProfilesController < ApplicationController
  before_action :user_not_authorized

  def edit
    @user = User.find(params[:id])
    only_current_user
  end

  def update
    @user = User.find(params[:id])

    ActiveRecord::Base.transaction do
      @user.update!(permit_params)
    end

    flash[:notice] = 'プロフィールを更新しました。'
    redirect_to action: :edit, id: @user.id
  rescue ActiveRecord::RecordInvalid
    render :edit
  end

  private

  def permit_params
    params.require(:user).permit(:name_first, :name_last)
  end

  def only_current_user
    return if current_user == @user

    flash[:error] = 'ログインユーザー以外の編集はできません'
    redirect_to root_url
  end
end
