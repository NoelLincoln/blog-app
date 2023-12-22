require 'rails_helper'

RSpec.describe Post, type: :model do
  # Create a valid post for use in tests
  let(:post) { FactoryBot.create(:post) }

  it 'is valid with valid attributes' do
    expect(post).to be_valid
  end

  it 'is not valid without a title' do
    post.title = nil
    expect(post).to_not be_valid
  end

  it 'is not valid if title exceeds 250 characters' do
    post.title = 'a' * 251
    expect(post).to_not be_valid
  end

  it 'is not valid if comments_counter is not an integer' do
    post.comments_counter = 'a'
    expect(post).to_not be_valid
  end

  it 'is not valid if comments_counter is less than zero' do
    post.comments_counter = -1
    expect(post).to_not be_valid
  end

  it 'is not valid if likes_counter is not an integer' do
    post.likes_counter = 'a'
    expect(post).to_not be_valid
  end

  it 'is not valid if likes_counter is less than zero' do
    post.likes_counter = -1
    expect(post).to_not be_valid
  end

  it 'returns the most recent comments' do
    # Create 6 comments at different times
    Timecop.freeze(Time.now - 6.days) { FactoryBot.create(:comment, post: post) }
    Timecop.freeze(Time.now - 5.days) { FactoryBot.create(:comment, post: post) }
    Timecop.freeze(Time.now - 4.days) { FactoryBot.create(:comment, post: post) }
    Timecop.freeze(Time.now - 3.days) { FactoryBot.create(:comment, post: post) }
    Timecop.freeze(Time.now - 2.days) { FactoryBot.create(:comment, post: post) }
    Timecop.freeze(Time.now - 1.day)  { FactoryBot.create(:comment, post: post) }

    # Get the recent comments
    recent_comments = post.recent_comments

    # Check that it returns 5 comments
    expect(recent_comments.count).to eq(5)

    # Check that the comments are returned in descending order of creation
    expect(recent_comments).to eq(recent_comments.sort_by(&:created_at).reverse)
  end
end
