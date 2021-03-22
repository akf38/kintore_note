FactoryBot.define do
  factory :training_record do
    weight { rand(0..1000) }
    rep { rand(0..1000) }
    set { rand(0..1000) }
  end
end
