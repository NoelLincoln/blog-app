require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:posts) { FactoryBot.create_list(:post, 5, author: user) }

  before do
    @recent_posts = FactoryBot.create_list(:post, 5, author: user)
    @user = user
    visit user_path(@user)
  end

  describe 'User show page' do
    it 'displays user photo' do
      expect(page).to have_css("img[alt='User Photo']")
    end

    it 'displays user bio' do
      expect(page).to have_content(user.bio)
    end

    it 'displays user name' do
      expect(page).to have_content(user.name)
    end

    it 'displays user posts count' do
      expect(page).to have_content(user.posts_counter)
    end

    it 'redirects to post show page' do
      find_all('a', text: @recent_posts.first.title)[0].click
      expect(page).to have_current_path(user_post_path(user, @recent_posts.first))
    end

    it 'displays user first three posts' do
      within('.user-posts-container') do
        displayed_posts = @user.recent_posts
        displayed_posts.each do |post|
          expect(page).to have_link('', href: user_post_path(@user, post))
        end
      end
    end

    it 'redirects to user posts index page' do
      click_link('See all posts')
      expect(page).to have_current_path(user_posts_path(user))
    end

    it 'displays user posts likes count' do
      posts.each do |post|
        expect(page).to have_content(post.likes_counter)
      end
    end

    it 'displays view all posts button' do
      expect(page).to have_link('See all posts')
    end

    it 'displays user posts comments count' do
      posts.each do |post|
        expect(page).to have_content(post.comments_counter)
      end
    end
  end
end
