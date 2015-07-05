FactoryGirl.define do
  sequence :email { |n| "test#{n}@example.com"}
  factory :user do
    email
    password 'Password01'
    password_confirmation 'Password01'
  end
end