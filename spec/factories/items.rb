FactoryGirl.define do
  factory :item do
    name "Example Item"
    price "9.99"
    inventory_number "example-inv-num"
    association :item_category

    trait :with_deposit do
      deposit "5.00"
    end

    trait :with_description do
      description "Example description."
    end
  end

  factory :item_with_deposit, traits: [:with_deposit]
  factory :item_with_description, traits: [:with_description]
  factory :item_full, traits: [:with_description, :with_deposit]
end
