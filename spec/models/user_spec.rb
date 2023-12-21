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
end
