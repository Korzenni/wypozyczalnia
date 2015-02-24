FactoryGirl.define do
  factory :membership do
    association :company
    association :user
    role 'user'
  end
end
