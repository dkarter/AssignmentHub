class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:name], params[:password])
    if user
      session[:name] = user.name
      redirect_to courses_path, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:name] = nil
    redirect_to sign_up_path, :notice => "Logged out!"
  end
end