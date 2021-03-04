class UserInfosController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @user_infos = @user.user_infos
  end
  
  def update
    @user_info = UserInfo.find(params[:id])
    if @user_info.update(user_info_params)
      redirect_to user_user_infos_path
    else
      render user_user_infos_path
    end
  end
  
  def destroy
    @user_info = UserInfo.find(params[:id])
    @user_info.destroy
    redirect_to user_user_infos_path
  end
  private
  def user_info_params
    params.require(:user_info).permit(:weight, :body_fat_percentage)
  end
end
