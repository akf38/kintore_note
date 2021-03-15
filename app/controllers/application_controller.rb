class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  add_flash_types :success, :info, :warning, :danger #flashのキーを許可する。

  protected
  # デバイス用のストロングパラメータ
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :image_id, :profile, :weight, :tall, :body_fat_percentage, :start_date])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :image, :profile, :start_date])
  end
end
