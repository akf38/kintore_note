class TweetsController < ApplicationController
  def index
    @tweet = Tweet.new
    # 自分+フォロー中ユーザーの投稿一覧
    @tweets = Tweet.where("user_id IN (?) OR user_id = ?", current_user.following_ids, current_user.id)
  end
  
  def show
    @tweet = Tweet.find(params[:id])
    @tweet_comment = TweetComment.new(user_id: current_user.id, tweet_id: @tweet.id)
  end
  
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    if @tweet.save
      redirect_to tweets_path
    else
      render 'index'
    end
  end
  
  private
  
  def tweet_params
    params.require(:tweet).permit(:content, :image)
  end
  
end
