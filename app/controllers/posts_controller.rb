# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  before_action :set_user, only: %i[index show new create]

  def index
    @user = User.find_by_id(params[:user_id])
    @posts = @user.posts.paginate(page: params[:page], per_page: 2)
  end

  def show
    @post = @user.posts.find(params[:id])
    @comments = @post.comments
    @comments_count = @comments.size
  end

  def new
    @user = User.find(params[:user_id])
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = 'Post saved successfully'
      redirect_to user_posts_path(@user)
    else
      flash.now[:error] = 'Error: Post could not be saved'
      puts "Errors: #{@post.errors.full_messages}"
      render :new
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
