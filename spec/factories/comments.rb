FactoryBot.define do
  factory :comment do
    text { 'Great read' }
    association :user, factory: :user
    association :post, factory: :post
  end
end
