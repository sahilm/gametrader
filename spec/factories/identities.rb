FactoryGirl.define do
  factory :identity do
    sequence(:provider) { |n| "Provider-#{n}" }
    uid SecureRandom.hex(10)
    sequence(:image) { |n| "http://example.org/?image=#{n}"}
    user
  end
end
