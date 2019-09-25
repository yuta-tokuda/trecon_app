FactoryBot.define do
  factory :user, aliases: [:created_by_user] do
    sequence(:email) { |n| "test_user#{ n }@trecon.co.jp" }
    password { 'password' }
    name_first { Faker::Japanese::Name.first_name }
    name_last { Faker::Japanese::Name.last_name }
  end
end
