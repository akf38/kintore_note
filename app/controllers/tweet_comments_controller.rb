class TweetCommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @tweet = Tweet.find(params[:tweet_id])
    if TweetComment.create(tweet_comment_params)
      respond_to do |format|
        format.html {redirect_back(fallback_location: root_path)}
        format.js
      end
    else
      render 'tweets/show'
    end
  end
  
  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    @tweet_comment = TweetComment.find(params[:id])
    @tweet_comment.destroy
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
