FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person-#{n}@example.org" }
    sequence(:first_name) { |n| "person-#{n}" }
  end
end
