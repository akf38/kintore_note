# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_soft_deleted_user, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected
  
  # 論理削除済みユーザーのログインを阻止するメソッド
  def reject_soft_deleted_user
    @user = User.find_by(email: params[:user][:email])
    if @user #まず、@userが存在するか確認。
      if (@user.valid_password?(params[:user][:password])) && (@user.is_deleted == true) #パスワードが一致かつ論理削除済みの場合
        flash[:error] = '退会済みユーザーです。'
        redirect_to root_path
      end
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
