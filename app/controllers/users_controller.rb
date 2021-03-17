class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    # グラフ描画のためのデータ。user_idに該当するものを、最新30件取得。各データ(体重、体脂肪率)を時間表示をchartkick指定にあわせて、再度配列化。
    data = UserInfo.where(user_id: @user.id).order(created_at: :desc).limit(30)
    @weight_data = data.select(:created_at, :weight).map { |d| [d.created_at.strftime('%Y%m%d').to_s, d.weight] }
    @body_fat_percentage_data = data.select(:created_at, :body_fat_percentage).map { |d| [d.created_at.strftime('%Y%m%d').to_s, d.body_fat_percentage] }
    
    if @user == current_user
      # 自分+フォロー中ユーザーの投稿一覧
      @tweets = Tweet.includes([:user]).where("user_id IN (?) OR user_id = ?", current_user.following_ids, current_user.id).order(created_at: :desc).limit(30)
    else
      # 自分+フォロー中ユーザーの投稿一覧
      @tweets = Tweet.includes([:user]).where(user_id: @user.id).order(created_at: :desc).limit(30)
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params) #ユーザー体型情報の更新が成功すれば、ユーザー体型記録テーブルへの保存も同時に行う。
      if @user_today_info = UserInfo.find_by(created_at: Time.zone.now.all_day) #もし、既に今日の体型情報が登録されていれば、その情報を更新する。
        @user_today_info.update(weight: @user.weight, body_fat_percentage: @user.body_fat_percentage)
      else #本日1回目の投稿であれば、今日の体型情報を作成。
        UserInfo.create(user_id: @user.id, weight: @user.weight, body_fat_percentage: @user.body_fat_percentage)
      end
      redirect_to user_path(@user)
    else
      render 'users/edit'
    end
  end
  
  # 論理削除メソッド
  def soft_delete
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = 'この度は、筋トレノートをご利用いただきありがとうございました。またのご登録を心よりお待ちしております。'
    redirect_to root_path
  end
  
  def following #フォロー中ユーザー一覧表示ページへの対応メソッド
    @user = User.find(params[:id])
    @title = "#{@user.name}さんのフォロー中リスト"
    @users = @user.following
    render 'follow_follower_list'
  end
  
  def followers #フォロワーユーザー一覧表示ページへの対応メソッド
    @user = User.find(params[:id])
    @title = "#{@user.name}さんのフォロワーリスト"
    @users = @user.followed
    render 'follow_follower_list'
  end
  
  private
  
  def user_params
    params.require(:user).permit(:tall, :weight, :body_fat_percentage, :image_id)
  end
  
end
