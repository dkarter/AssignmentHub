class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.forgot_password(user.name, user.email) if user
    redirect_to "/", :notice => "Email sent with password reset instructions."
  end
end
