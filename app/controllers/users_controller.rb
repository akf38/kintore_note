class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
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
