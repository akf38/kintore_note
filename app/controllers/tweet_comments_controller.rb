class TweetCommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @tweet = Tweet.find(params[:tweet_id])
    @tweet_comment = TweetComment.new(tweet_comment_params)
    if @tweet_comment.save
      @tweet_comment = TweetComment.new(user_id: current_user.id, tweet_id: @tweet.id)
    end
    @tweet_comments = TweetComment.includes([:user]).where(tweet_id: @tweet.id)
    respond_to do |format|
      format.html {redirect_back(fallback_location: root_path)}
      format.js
    end
  end
  
  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    @tweet_comment = TweetComment.find(params[:id])
    @tweet_comment.destroy
    @tweet_comments = TweetComment.includes([:user]).where(tweet_id: @tweet.id)
    respond_to do |format|
      format.html {redirect_back(fallback_location: root_path)}
      format.js
    end
  end
  
  private
  
  def tweet_comment_params
    params.require(:tweet_comment).permit(:content, :image).merge(tweet_id: params[:tweet_id], user_id: current_user.id)
  end
end
