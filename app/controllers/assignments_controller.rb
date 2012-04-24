# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#AssignmentHub - My School Organizer on the Cloud
# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#Copyright (C) 2012 Dorian Karter, Joseph Low, Amar Rana
# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
#documentation files (the "Software"), to deal in the Software without restriction, including without limitation
#the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and
#to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all copies or substantial portions
#of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
#TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
#THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
#CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
#DEALINGS IN THE SOFTWARE.
# * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

class AssignmentsController < ApplicationController
  # GET /assignments
  # GET /assignments.json
  def index
    if current_user && !is_admin
      @assignments = Assignment.where(:user_id => User.find(current_user))
    elsif is_admin
      @assignments = Assignment.all
    else
      @assignments = nil
      redirect_to sign_up_path and return
    end
    
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @assignments }
    end
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
    @assignment = Assignment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @assignment.to_json }
    end
  end

  # GET /assignments/new
  # GET /assignments/new.json
  def new
    #assignments/new_for_course/:course_id
    @assignment = Assignment.new
    @assignment.user = User.find(current_user)
    
    if params[:course_id]
      @assignment.course_id = Course.where(:id => params[:course_id], :user_id => @assignment.user.id).first.id
    else
      @courses = Course.where(:user_id => @assignment.user)
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @assignment }
    end
  end

  def schedule_notification
    if request.post? and params[:assignment]
      @assignment = Assignment.new(params[:assignment])
      assignment = Assignment.find_by_name(@assignment.name)
      flash[:notice] = "Received assignment!"
    end
  end

  # GET /assignments/1/edit
  def edit
    @assignment = Assignment.find(params[:id])
    @assignment.user = User.find(current_user) if !@assignment.user
    @courses = Course.where(:user_id => @assignment.user)
  end

  # POST /assignments
  # POST /assignments.json
  def create
    @assignment = Assignment.new(params[:assignment])
    @assignment.notification_type = params[:notification_type].to_s
    @assignment.user = User.find(current_user)
    @courses = Course.where(:user_id => @assignment.user)
    
    respond_to do |format|
      if @assignment.save
        format.html { redirect_to @assignment, notice: 'Assignment was successfully created.' }
        format.json { render json: @assignment, status: :created, location: @assignment }
      else
        format.html { render action: "new" }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /assignments/1
  # PUT /assignments/1.json
  def update
    @assignment = Assignment.find(params[:id])

    respond_to do |format|
      if @assignment.update_attributes(params[:assignment])
        format.html { redirect_to @assignment, notice: 'Assignment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.json
  def destroy
    @assignment = Assignment.find(params[:id])
    @assignment.destroy
    
    respond_to do |format|
      format.html { redirect_to assignments_url }
      format.js   { render :nothing => true }
      format.json { head :no_content }
    end
  end
end
