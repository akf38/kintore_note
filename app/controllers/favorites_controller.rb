class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @favorite = current_user.favorites.create(tweet_id: params[:tweet_id])
    @tweet.create_notification_by(current_user) # 通知の作成
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end

  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    @favorite = Favorite.find_by(user_id: current_user.id, tweet_id: @tweet.id)
    @favorite.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end
end
