class Users::ConfirmationsController < Devise::ConfirmationsController
  def create
    user = User.find_by(email: params[:user][:email])

    if user && !user.confirmed?
      user.confirm
      sign_in(user)
      redirect_to users_path
    else
      redirect_to new_user_confirmation_path
    end
  end
end
