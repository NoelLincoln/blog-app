# app/controllers/users/posts_controller.rb
module Users
  class PostsController < ApplicationController
    before_action :set_user, only: %i[index show]

    def index
      @posts = @user.posts
    end

    def show
      @post = @user.posts.find(params[:id])
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end
  end
end
