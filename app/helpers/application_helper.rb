module ApplicationHelper
  # 開始日(start_date)から現在までの経過期間を計算する
  def calc_date_diff(start_date)
    d1 = start_date
    d2 = Date.today

    if d1.day > d2.day # 月調整の必要がある場合。
      diff_month = d2.year * 12 + d2.month - d1.year * 12 - d1.month - 1 # -1で月のズレを調整
      if d1.year % 4 == 0 # 閏年の場合
        case d1.month
        when 4 || 6 || 9 || 11
          diff_day = 30 - d1.day + d2.day
        when 2
          diff_day = 29 - d1.day + d2.day
        else
          diff_day = 31 - d1.day + d2.day
        end
      else
        case d1.month
        when 4 || 6 || 9 || 11
          diff_day = 30 - d1.day + d2.day
        when 2
          diff_day = 28 - d1.day + d2.day
        else
          diff_day = 31 - d1.day + d2.day
        end
      end
    else
      diff_month = d2.year * 12 + d2.month - d1.year * 12 - d1.month
      diff_day = d2.day - d1.day
    end

    diff_year = diff_month / 12
    diff_month = diff_month % 12
    "#{diff_year}年#{diff_month}ヶ月#{diff_day}日"
  end

  # deviseのflashをbootstrapに対応させる。
  def devise_flashkey_to_bootstrap(key)
    case key
    when "alert"
      "warning"
    when "notice"
      "success"
    when "error"
      "danger"
    end
  end
end
