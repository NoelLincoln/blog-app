require 'rails_helper'

RSpec.describe 'PostIndex', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, author: user) }
  let(:comments) { FactoryBot.create_list(:comment, 3, post:, text: 'old', user:, created_at: 4.days.ago) }

  let(:recent_comments) { FactoryBot.create_list(:comment, 5, post:, text: 'new', user:) }

  before do
    post
    comments
    recent_comments
    visit user_posts_path(user)
  end

  describe 'User section in user posts index' do
    it 'shows user name' do
      expect(page).to have_content(user.name)
    end

    it 'shows user photo' do
      expect(page).to have_css("img[alt='User Photo']")
    end

    it 'shows user posts count' do
      expect(page).to have_content(user.posts_counter)
    end
  end

  it 'Shows how many likes a post has' do
    expect(page).to have_content(post.likes_counter)
  end

  describe 'Posts section in user posts index' do
    it 'Shows post heading' do
      expect(page).to have_css('h2#post-title')
    end

    it 'Shows post content' do
      expect(page).to have_content(post.text)
    end

    it 'Shows pagination section if there are more posts than fit on the view' do
      FactoryBot.create_list(:post, 10, author: user)
      visit user_posts_path(user)
      expect(page).to have_css('div.pagination')
    end
  end
end
