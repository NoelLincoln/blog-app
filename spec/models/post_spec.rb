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
end
