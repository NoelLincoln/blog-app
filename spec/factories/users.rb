FactoryBot.define do
  factory :user do
    name { 'Noel' }
    photo { 'https://www.wers.ke' }
    bio { 'Learn something new everyday' }
    posts_counter { 1 }
  end
end
