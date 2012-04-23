class DashboardController < ApplicationController
  def index
    if current_user && User.find(current_user).user_type > 0
      @courses = Course.where(:user_id => User.find(current_user))
    else
      @courses = nil
      redirect_to sign_up_path and return
    end
  end

end
