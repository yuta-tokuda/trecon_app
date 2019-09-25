FactoryBot.define do
  factory :notification do
    association :active_user
    association :passive_user
    association :note
    association :comment

    trait :comment_notification do
      kind { 'comment' }
    end

    trait :note_notification do
      kind { 'note' }
    end
  end
end
