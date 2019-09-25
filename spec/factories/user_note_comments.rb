FactoryBot.define do
  factory :user_note_comment do
    content { 'テスト投稿' }
    association :editor
    association :reply_user
    association :note
  end
end
