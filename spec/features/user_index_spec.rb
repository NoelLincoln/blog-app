require 'rails_helper'

RSpec.describe 'Users index', type: :feature do
  let(:users) { FactoryBot.create_list(:user, 5) }

  before do
    users
    visit users_path
  end

  describe 'Users index page' do
    it 'displays correct number of users' do
      expect(page).to have_css('div.margin-tp-2', count: 5)
    end

    it 'displays all users photos' do
      users.each do |_user|
        expect(page).to have_css("img[alt='User Photo']")
      end
    end

    it 'displays all users names' do
      users.each do |user|
        expect(page).to have_content(user.name)
      end
    end

    it 'displays all users posts count' do
      users.each do |user|
        expect(page).to have_content(user.posts_counter)
      end
    end

    # When I click on a user, I am redirected to that user's show page

    it 'redirects to user show page' do
      find_all('a', text: users.first.name)[0].click
      expect(page).to have_current_path(user_path(users.first))
    end
  end
end
