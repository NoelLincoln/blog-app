# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.includes(posts: :comments).find_by_id(params[:id])
    @recent_posts = @user.recent_posts
  end
end
