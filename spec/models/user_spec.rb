require 'rails_helper'

RSpec.describe User, type: :model do
  # Create a valid user for use in tests
  let(:user) { FactoryBot.create(:user) }

  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user.name = nil
    expect(user).to_not be_valid
  end

  it 'is not valid if posts_counter is not an integer' do
    user.posts_counter = 'a'
    expect(user).to_not be_valid
  end

  it 'is not valid if posts_counter is less than zero' do
    user.posts_counter = -1
    expect(user).to_not be_valid
  end

  it 'returns the most recent posts' do
    # Create 4 posts at different times
    Timecop.freeze(Time.now - 4.days) { FactoryBot.create(:post, author: user) }
    Timecop.freeze(Time.now - 3.days) { FactoryBot.create(:post, author: user) }
    Timecop.freeze(Time.now - 2.days) { FactoryBot.create(:post, author: user) }
    Timecop.freeze(Time.now - 1.day) { FactoryBot.create(:post, author: user) }

    # Get the recent posts
    recent_posts = user.recent_posts

    # Check that it returns 3 posts
    expect(recent_posts.count).to eq(3)

    # Check that the posts are returned in descending order of creation
    expect(recent_posts).to eq(recent_posts.sort_by(&:created_at).reverse)
  end
end
