class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.includes([:tweet]).includes([:visiter])
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
  
  def destroy_all
    # 通知を全削除
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end
end
