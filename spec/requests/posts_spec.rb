# spec/requests/posts_spec.rb
require 'rails_helper'

RSpec.describe 'PostsController', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, author: user) }

  describe 'GET /users/:user_id/posts' do
    it 'renders the index template and returns a 200 OK status' do
      get "/users/#{user.id}/posts"
      expect(response).to render_template(:index)
      expect(response).to have_http_status(:ok)
    end

    it 'includes correct placeholder text in the response body' do
      get "/users/#{user.id}/posts"
      expect(response.body).to include('Number of posts')
    end
  end

  describe 'GET /users/:user_id/posts/:id' do
    it 'renders the show template and returns a 200 OK status' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to render_template(:show)
      expect(response).to have_http_status(:ok)
    end

    it 'includes correct placeholder text in the response body' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response.body).to include('Add Comment')
    end
  end
end
