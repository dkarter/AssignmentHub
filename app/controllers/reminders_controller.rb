class RemindersController < ApplicationController

  def new
  end

  def create
    assignment = Assignment.find_by_name(params[:name])
    assignment.schedule_notification() if assignment
    redirect_to "/", :notice => "A reminder email will be sent 24 hours in advance!"
  end
end