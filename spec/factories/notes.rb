FactoryBot.define do
  factory :note do
    title { 'テストタイトル' }
    content { Faker::Lorem.sentence }
    association :created_by_user

    # 公開可能ノート
    trait :public_note do
      public_flag { true }
    end

    # 公開不可ノート
    trait :private_note do
      public_flag { false }
    end
  end
end
