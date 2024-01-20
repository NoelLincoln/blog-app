class Api::V1::PostsController < ApplicationController
  before_action :set_user, only: %i[create]
  load_and_authorize_resource

  def index
    @posts = User.find(params[:user_id]).posts.includes(:comments)
    render json: @posts
  end

  def create
    @post = @user.posts.build(post_params)

    if @post.save
      render json: @post, status: :created
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    return if request.headers['Authorization'].nil?

    token = request.headers['Authorization'].split.last
    @user = User.find_by(token:)
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
