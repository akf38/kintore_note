class UserInfosController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update, :destroy]

  def index
    @user = User.find(params[:user_id])
    @user_infos = @user.user_infos.order(created_at: :desc).page(params[:page]).per(10)

    # グラフ描画のためのデータ。user_idに該当するものを、最新30件取得。各データ(体重、体脂肪率)を時間表示をchartkick指定にあわせて、再度配列化。
    data = UserInfo.where(user_id: @user.id).order(created_at: :desc).limit(30)
    weight_data = data.select(:created_at, :weight)
    @weight_data = weight_data.map { |d| [d.created_at.strftime('%Y%m%d').to_s, d.weight] }
    bfp_data = data.select(:created_at, :body_fat_percentage)
    @bfp_data = bfp_data.map { |d| [d.created_at.strftime('%Y%m%d').to_s, d.body_fat_percentage] }
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
