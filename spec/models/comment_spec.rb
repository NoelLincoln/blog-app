require 'rails_helper'

RSpec.describe Comment, type: :model do
  # Create a valid comment for use in tests
  let(:comment) { FactoryBot.create(:comment) }

  it 'is valid with valid attributes' do
    expect(comment).to be_valid
  end

  it 'is not valid without a user' do
    comment.user = nil
    expect(comment).to_not be_valid
  end

  it 'is not valid without a post' do
    comment.post = nil
    expect(comment).to_not be_valid
  end

  it 'updates the comments_counter of the associated post after creation' do
    post = FactoryBot.create(:post)
    expect do
      FactoryBot.create(:comment, post:)
    end.to change { post.reload.comments_counter }.by(1)
  end
end
