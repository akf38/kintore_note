class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:destroy]

  def index
    @tweet = Tweet.new
    if params[:tag].present?
      @tweets = Tweet.includes([:user]).tagged_with(params[:tag]).page(params[:page]).per(15)
    else
      # 自分+フォロー中ユーザーの投稿一覧
      tweets = Tweet.get_self_and_following_tweets(current_user)
      @tweets = tweets.order(created_at: :desc).page(params[:page]).per(15)
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
    @tweet_comment = TweetComment.new(user_id: current_user.id, tweet_id: @tweet.id)
    @tweet_comments = TweetComment.includes([:user]).where(tweet_id: @tweet.id)
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    if @tweet.save
      tweets = Tweet.get_self_and_following_tweets(current_user)
      @tweets = tweets.order(created_at: :desc).page(params[:page]).per(15)
      redirect_to tweets_path
    else
      tweets = Tweet.get_self_and_following_tweets(current_user)
      @tweets = tweets.order(created_at: :desc).page(params[:page]).per(15)
      render 'tweets/index'
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    tweets = Tweet.get_self_and_following_tweets(current_user)
    @tweets = tweets.order(created_at: :desc).page(params[:page]).per(15)
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content, :image, :tag_list)
  end

  def ensure_correct_user
    @tweet = Tweet.find(params[:id])
    @user = @tweet.user
    unless @user == current_user
      redirect_back(fallback_location: root_path)
    end
  end
end
