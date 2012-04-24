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

class AttachmentsController < ApplicationController
  # GET /attachments
  # GET /attachments.json
  def index
    if params[:assignment_id]
      @attachments = Attachment.where(:assignment_id => params[:assignment_id], :user_id => User.find(current_user))
    else
      @attachments = Attachment.all
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @attachments.collect { |a| a.to_jq_upload }.to_json }
      
    end
  end

  # GET /attachments/1
  # GET /attachments/1.json
  def show
    @attachment = Attachment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @attachment }
    end
  end

  # GET /attachments/new
  # GET /attachments/new.json
  def new
    @attachment = Attachment.new
    @courses = Course.where(:user_id => current_user)
    @assignments = Assignment.where(:user_id => current_user)
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @attachment }
    end
  end

  # GET /attachments/1/edit
  def edit
    @attachment = Attachment.find(params[:id])
    @courses = Course.where(:user_id => @attachment.user)
    @assignments = Assignment.where(:user_id => current_user)
  end

  # POST /attachments
  # POST /attachments.json
  def create
    @attachment = Attachment.new(params[:attachment])
    
    # set current user as the creator of the attachment 
    @attachment.user = User.find(current_user)
    
    #from jquery upload
    @attachment.name = params[:title] if params[:title]
    
    
    if params[:assignment_id]
      @attachment.assignment = Assignment.find(params[:assignment_id])
      @attachment.course = @attachment.assignment.course
    end
    
    respond_to do |format|
      if @attachment.save
        format.html { redirect_to @attachment, notice: 'Attachment was successfully created.' }
        format.json { render :json => [@attachment.to_jq_upload].to_json }
      else
        format.html { render action: "new" }
        format.json { render :json => [{:error => "custom_failure"}], :status => 304 }
      end
    end
  end

  # PUT /attachments/1
  # PUT /attachments/1.json
  def update
    @attachment = Attachment.find(params[:id])

    respond_to do |format|
      if @attachment.update_attributes(params[:attachment])
        format.html { redirect_to @attachment, notice: 'Attachment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attachments/1
  # DELETE /attachments/1.json
  def destroy
    @attachment = Attachment.find(params[:id])
    #TODO: delete file from disk (folder too)
    @attachment.destroy

    respond_to do |format|
      format.html { redirect_to attachments_url }
      format.js   { render :nothing => true }
      format.json { render :json => true }
    end
  end
end
