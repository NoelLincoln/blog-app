require 'rails_helper'

RSpec.describe Like, type: :model do
  # Create a valid like for use in tests
  let(:like) { FactoryBot.create(:like) }

  it 'is valid with valid attributes' do
    expect(like).to be_valid
  end

  it 'is not valid without a user' do
    like.user = nil
    expect(like).to_not be_valid
  end

  it 'is not valid without a post' do
    like.post = nil
    expect(like).to_not be_valid
  end

  it 'updates the likes_counter of the associated post after creation' do
    post = FactoryBot.create(:post)
    expect {
      FactoryBot.create(:like, post: post)
    }.to change { post.reload.likes_counter }.by(1)
  end
end
