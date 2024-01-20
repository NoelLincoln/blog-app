# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.includes(posts: :comments).find_by_id(params[:id])
    @recent_posts = @user.recent_posts
  end

  def generate_token
    @user = User.find(current_user.id)
    @user.generate_token
    if @user.save
      flash[:success] = 'Token generated successfully'
    else
      flash[:error] = @user.errors.full_messages.join(', ')
    end
    redirect_to user_path(@user)
  end
end
