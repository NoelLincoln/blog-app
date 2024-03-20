# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.includes(posts: :comments).find_by_id(params[:id])
    @recent_posts = @user.recent_posts
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :bio, :email, :password, :password_confirmation)
  end
end
