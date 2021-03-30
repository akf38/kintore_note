module NotificationsHelper
  
  def notification_form(notification)
    @visiter = notification.visiter
    @comment = nil
    # notification.actionがfollowかlikeかcommentかで分岐
    case notification.action
    when 'follow'
      tag.a(notification.visiter.name, href:user_path(@visiter.id), style:'font-weight: bold;')+'があなたをフォローしました'
    when 'like'
      tag.a(notification.visiter.name, href:user_path(@visiter.id), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:tweet_path(notification.item_id), style:"font-weight: bold;")+"にいいねしました"
    when 'comment'
      tag.a(notification.visiter.name, href:user_path(@visiter.id), style:'font-weight: bold;')+'が'+tag.a('あなたに関わる投稿', href:tweet_path(notification.item_id), style:'font-weight: bold;')+'にコメントしました'
    end
  end
  
  #未確認の通知があるか判定 
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
  
end
