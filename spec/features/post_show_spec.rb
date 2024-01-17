require 'rails_helper'

RSpec.describe 'PostShow', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, author: user) }
  let(:comments) { FactoryBot.create_list(:comment, 3, post:, user:) }
  let(:likes) { FactoryBot.create_list(:like, 2, post:, user:) }

  before do
    post
    comments
    likes
    visit user_post_path(user, post)
  end

  describe 'Post details' do
    it 'shows post title' do
      expect(page).to have_content(post.title)
    end

    it 'shows post author' do
      expect(page).to have_content(user.name)
    end

    it 'shows number of comments' do
      expect(page).to have_content(post.comments.count)
    end

    it 'shows number of likes' do
      expect(page).to have_content(post.likes.count)
    end

    it 'shows post body' do
      expect(page).to have_content(post.text)
    end
  end

  describe 'Comments section' do
    it 'shows username of each commentor' do
      comments.each do |comment|
        expect(page).to have_content(comment.user.name)
      end
    end

    it 'shows the comment each commentor left' do
      comments.each do |comment|
        expect(page).to have_content(comment.text)
      end
    end
  end
end
