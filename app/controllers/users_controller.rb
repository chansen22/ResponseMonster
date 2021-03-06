class UsersController < ApplicationController
  before_filter :authenticate, except: [:new, :create]
  before_filter :check_correct_user, only: [:show, :edit]
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
      flash[:success] = "Welcome to ResponseMonster!"
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
      @enrolled = current_user.courses.all
      @taught = Course.where(teacher_id: current_user.id)
      @open_surveys = Survey.where(course_id: current_user.courses + @taught,
                                   is_active: true)
      render 'home'
    else
      render 'sessions/new'
    end
  end

  private
    def check_correct_user
      @user = User.find(params[:id])
      if @user != current_user and not current_user.admin?
        redirect_to root_path, notice: "You cannot view other users' profiles."
      end
    end
end
