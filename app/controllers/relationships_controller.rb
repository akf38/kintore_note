class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    # ajax非同期通信用の分岐。遷移元がユーザー一覧ページであれば、followカウントに渡す値をcurrent_userに指定する。(create.js.erb参照)
    if request.referer&.include?("/users/") 
      @count_user = @user
    else
      @count_user = current_user
    end
    respond_to do |format|
      format.html {redirect_back(fallback_location: root_path)}
      format.js
    end
  end
  
  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    # ajax非同期通信用の分岐。遷移元がユーザー一覧ページであれば、followカウントに渡す値をcurrent_userに指定する。(destroy.js.erb参照)
    if request.referer&.include?("/users/") 
      @count_user = @user
    else
      @count_user = current_user
    end
    respond_to do |format|
      format.html {redirect_back(fallback_location: root_path)}
      format.js
    end
  end
  
end
