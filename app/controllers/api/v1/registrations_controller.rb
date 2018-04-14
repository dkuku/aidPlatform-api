class Api::V1::RegistrationsController < Devise::RegistrationsController
  #sign up
  def create
    user = User.new user_params
    if user.save
      json_response "Signed Up successfully", true, {user: user }, :ok
    else
      json_response user.errors.full_messages.first, false, {}, :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :picture)
  end
end
