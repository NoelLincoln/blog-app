FactoryBot.define do
  factory :user do
    name { 'Noel' }
    photo { 'https://images.unsplash.com/' }
    bio { 'Learn something new everyday' }
    posts_counter { 0 }
  end
end
