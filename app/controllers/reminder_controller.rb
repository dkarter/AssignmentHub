class RemindersController < ApplicationController
  def new
  end

  def create
    assignment = Assignment.find(params[:id])
    assignment.schedule_notification() if assignment
    redirect_to root_url, :notice => "A reminder email will be sent 24 hours in advance!"
  end
end