FactoryBot.define do
  factory :notification do
    visiter_id { "" }
    visited_id { "" }
    tweet_id { "" }
    tweet_comment_id { "" }
    action { "" }
    checked { false }
  end
end
