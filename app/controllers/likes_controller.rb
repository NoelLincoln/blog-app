class LikesController < ApplicationController
  def new
    @like = Like.new
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @like = @post.likes.build(user: current_user)

    if @like.save
      redirect_to user_post_path(@user, @post), notice: 'Like was successfully created.'
    else
      render :new
    end
  end
end
