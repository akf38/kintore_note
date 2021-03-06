# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # callback for facebook
  def facebook
    callback_for(:facebook)
  end

  # callback for twitter
  def twitter
    callback_for(:twitter)
  end

  # callback for google
  def google_oauth2
    callback_for(:google)
  end

  # 共通のcallbackメソッド（request.env[omniauth.auth]の中に取得したユーザー情報が入っている。）
  def callback_for(provider)
    user = User.find_by(email: request.env["omniauth.auth"].info.email)
    if !user.nil? && user.provider != request.env["omniauth.auth"].provider
      flash[:notice] = '他サービスにて登録済みです。'
      redirect_to new_user_session_path
      return
    end
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted? # DBに保存済みかを確認。つまり、from_omniauthでエラーが起こってないか確認している。新規登録でも既存ユーザーのログインでもここを通る。
      sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
      if is_navigational_format?
        set_flash_message(:notice, :success, kind: "#{provider}".capitalize)
      end
    else
      session["devise.#{provider}_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url
    end
  end

  def failure # Gem内部で定義されている。
    redirect_to root_path
  end

  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
