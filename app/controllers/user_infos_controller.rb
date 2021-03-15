class UserInfosController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update, :destroy]
  
  def index
    @user = User.find(params[:user_id])
    @user_infos = @user.user_infos.order(created_at: :desc).page(params[:page]).per(10)
  end
  
  def update
    @user_info = UserInfo.find(params[:id])
    if @user_info.update(user_info_params)
      redirect_to user_user_infos_path
    else
      render user_user_infos_path(@user.id)
    end
  end
  
  def destroy
    @user_info = UserInfo.find(params[:id])
    @user_info.destroy
    redirect_to user_user_infos_path(@user.id)
  end
  
  private
  
  def user_info_params
    params.require(:user_info).permit(:weight, :body_fat_percentage)
  end
  
  def ensure_correct_user
    @user_info = UserInfo.find(params[:id])
    @user = @user_info.user
    unless @user == current_user
      redirect_to user_user_infos_path(@user.id)
    end
  end
end
