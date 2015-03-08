FactoryGirl.define do
  factory :item_category do
    name "Example Item Category"
    price "9.99"
    association :company

    trait :with_deposit do
      deposit "5.00"
    end

    trait :with_description do
      description "Example description."
    end
  end

  factory :item_category_with_deposit, traits: [:with_deposit]
  factory :item_category_with_description, traits: [:with_description]
  factory :item_category_full, traits: [:with_description, :with_deposit]
end
