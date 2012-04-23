class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    if current_user
      @curr = User.find(current_user)
      if @curr.user_type == 0
          @users = User.all
      else
        redirect_to '/' and return
      end
    else
      redirect_to sign_up_path and return
    end


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def login
    if request.post? and params[:user]
      @user = User.new(params[:user])
      user = User.find_by_username(@user.name)
      if user and user.password_matches?(@user.password)
        flash[:notice] = "Logged in!"
      else
        flash[:warning] = "Couldn't log in!"
      end
    end
  end

  def forgot_password
    if request.post? and params[:user]
      @user = User.new(params[:user])
      user = User.find_by_email(@user.email)
      flash[:notice] = "Received email!"
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.js   { render :nothing => true }
      format.json { head :no_content }
    end
  end
end
