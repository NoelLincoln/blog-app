# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  before_action :set_user, only: %i[index show]

  def index
    @user = User.find_by_id(params[:user_id])
    @posts = @user.posts.paginate(page: params[:page], per_page: 2)
  end

  def show
    @post = @user.posts.find(params[:id])
    @comments = @post.comments
    @comments_count = @comments.size
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
