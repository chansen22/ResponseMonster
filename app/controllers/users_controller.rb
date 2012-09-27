class UsersController < ApplicationController
  before_filter :authenticate
  before_filter :admin_user, only: [:index]
  
  def index
    @users = User.all

    respond_to do |format|
      format.html 
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html 
      format.json { render json: @user }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html 
      format.json { render json: @user }
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Response Monster"
      redirect_to root_path
    else
      render 'new'
    end
  end
  
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
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def home
    if current_user
      @courses = Course.all
      render 'home'
    else
      render 'sessions/new'
    end
  end

  private

    def authenticate
      redirect_to signin_path unless signed_in?
    end

    def admin_user
      redirect_to root_path unless is_admin?
    end
end
