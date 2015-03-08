FactoryGirl.define do
  factory :user do
    name "Test User"
    sequence(:email) { |n| "test-#{n}@example.com" }
    password "12345678"

    trait :with_company do
      after(:create) do |user|
        user.companies.create(name: "Test")
      end
    end
  end

  factory :user_with_company, traits: [:with_company]
end
