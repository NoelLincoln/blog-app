FactoryBot.define do
  factory :post do
    title { 'first test Post' }
    text { 'Learning never stops' }
    comments_counter { 0 }
    likes_counter { 0 }
    association :author, factory: :user

  end
end
