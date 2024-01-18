require 'rails_helper'

RSpec.describe 'PostIndex', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:posts) { FactoryBot.create_list(:post, 5, author: user) }

  let(:comments) do
    FactoryBot.create_list(:comment, 3, post: posts.first, text: 'old', user:, created_at: 4.days.ago)
  end

  let(:recent_comments) { FactoryBot.create_list(:comment, 5, post: posts.first, text: 'new', user:) }

  before do
    posts
    comments
    recent_comments

    visit user_posts_path(user)

    @posts = posts
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

  describe 'Posts section in user posts index' do
    it 'shows post heading' do
      expect(page).to have_css('h2.post-title')
    end

    it 'shows post content' do
      expect(page).to have_content(posts.first.text)
    end

    it 'shows pagination section if there are more posts than fit on the view' do
      FactoryBot.create_list(:post, 10, author: user)
      visit user_posts_path(user)
      expect(page).to have_css('div.pagination')
    end

    it 'displays the first comments on a post' do
      within('.comments-index') do
        first_post = posts.first
        expect(page).to have_content(first_post.comments.first.text)
      end
    end

    it 'displays how many comments a post has' do
      within('.comments-index') do
        first_post = posts.first
        expect(page).to have_content("comments: #{first_post.comments.count}")
      end
    end

    it 'redirects to the post show page when clicking on a post' do
      within('.comments-index') do
        first_link = find('a', match: :first)
        first_link.click
        expect(page).to have_current_path(%r{/users/\d+/posts/\d+})
      end
    end
  end
end
