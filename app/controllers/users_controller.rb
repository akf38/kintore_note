class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    # グラフ描画のためのデータ。user_idに該当するものを、最新30件取得。各データを時間表示をchartkick指定にあわせて、再度配列化。
    data = UserInfo.where(user_id: @user.id).order(created_at: :desc).limit(30)
    @weight_data = data.select(:created_at, :weight).map { |d| [d.created_at.strftime('%Y%m%d').to_s, d.weight] }
    @body_fat_percentage_data = data.select(:created_at, :body_fat_percentage).map { |d| [d.created_at.strftime('%Y%m%d').to_s, d.body_fat_percentage] }
  end
  
  def edit
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params) #ユーザー体型情報の更新が成功すれば、ユーザー体型記録テーブルへの保存も同時に行う。
      UserInfo.create(user_id: @user.id, weight: @user.weight, body_fat_percentage: @user.body_fat_percentage)
      redirect_to user_path(@user)
    else
      render edit_user_path(@user)
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:tall, :weight, :body_fat_percentage, :image_id)
  end
end
