# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params.merge(user_id: current_user.id))

    if @comment.save
      flash[:success] = 'Comment saved successfully'
      redirect_to user_post_path(@post.author, @post) # Redirect to the post show page
    else
      flash[:error] = 'Failed to save comment'
      redirect_back(fallback_location: root_path) # Redirect back to the previous page
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    if @comment.destroy
      flash[:success] = 'Comment deleted successfully'
    else
      flash[:error] = 'Error: Comment could not be deleted'
    end

    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
