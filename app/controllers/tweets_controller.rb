class TweetsController < ApplicationController
  def index
    @tweet = Tweet.new
    @tweets = Tweet.all
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
