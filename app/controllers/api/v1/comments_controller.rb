class Api::V1::CommentsController < ApplicationController
  before_action :set_user_and_post, only: %i[create]

  load_and_authorize_resource

  def index
    @comments = Comment.where(post_id: params[:post_id], author_id: params[:user_id])
    render json: @comments
  end

  def create
    @comment = @post.comments.build(comment_params.merge(author_id: @user.id))

    if @comment.save
      render json: @comment, status: :created
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def set_user_and_post
    return if request.headers['Authorization'].nil?

    token = request.headers['Authorization'].split.last
    @user = User.find_by(token:)
    @post = @user.posts.includes(:comments).find(params[:post_id])
  end
end
