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

class CoursesController < ApplicationController
  
  autocomplete :university, :name, :full => true
  
  # GET /courses
  # GET /courses.json
  def index
    #@courses = Course.all
    
    #this is supposed to show only the courses assigned for the user
    #if false
      if current_user && User.find(current_user).user_type > 0
        @courses = Course.where(:user_id => User.find(current_user))
      elsif current_user && User.find(current_user).user_type == 0
        @courses = Course.all
      else
        @courses = nil
        redirect_to sign_up_path and return
      end
    #end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @courses }
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @course = Course.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course }
    end
  end

  # GET /courses/new
  # GET /courses/new.json
  def new
    @course = Course.new
    @course.color = get_random_color
    @last_school_used = last_school_used
    
    #2.times { @course.teachers.build }
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course }
    end
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:id])
    @instructors = @course.teachers
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(params[:course])
    
    # set current user as the creator of the course 
    @course.user = User.find(current_user)
    
    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.js
        format.json { render json: @course, status: :created, location: @course }
      else
        format.html { render action: "new" }
        format.js
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /courses/1
  # PUT /courses/1.json
  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.js
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.js
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url }
      format.js   { render :nothing => true }
      format.json { head :no_content }
    end
  end
  
  def get_random_color
    return "%06x" % (rand * 0xffffff)
  end
  
  def last_school_used
		last_course = Course.where(:user_id => User.find(current_user)).find(:first, :order => "updated_at DESC", :limit => 1)
		if last_course
			last_school_used = last_course.school
    end
  end
  
  # GET /courses/1
  # GET /courses/1.json
  def search(search)
    #@courses = Course.where(:published => true).find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    courses_tbl = Course.arel_table
    @courses = Course.where(:published => true)
    
    respond_to do |format|
      format.html
      format.js
      format.json { render json: @course }
    end
  end
  
end
