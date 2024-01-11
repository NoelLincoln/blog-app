# spec/requests/users_spec.rb
require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  describe 'GET /users' do
    it 'renders the index template and returns a 200 OK status' do
      get '/users'
      expect(response).to render_template(:index)
      expect(response).to have_http_status(:ok)
    end

    it 'includes correct placeholder text in the response body' do
      get '/users'
      expect(response.body).to include('All users')
    end
  end

  describe 'GET /users/:id' do
    let(:user) { FactoryBot.create(:user) }

    it 'renders the show template and returns a 200 OK status' do
      get "/users/#{user.id}"
      expect(response).to render_template(:show)
      expect(response).to have_http_status(:ok)
    end

    it 'includes correct placeholder text in the response body' do
      get "/users/#{user.id}"
      expect(response.body).to include('All users show')
    end
  end
end
