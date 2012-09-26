class CoursesController < ApplicationController
  before_filter :authenticate
  before_filter :admin_user, only: [:new, :create, :destroy]

  def index
    @courses = Course.all

    respond_to do |format|
      format.html
      format.json { render json: @courses }
    end
  end

  def show
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
    @users = User.all

    respond_to do |format|
      format.html
      format.json { render json: @course }
    end
  end

  def edit
    @course = Course.find(params[:id])
    @users = User.all
  end

  def create
    @course = Course.new(params[:course])

    @course.teacher_id = params[:teacher][:user_id]

    if params[:term] == "Fall"
      @course.term = Date.new(Date.today.year, 8, 1)
    else
      @course.term = Date.new(Date.today.year, 1, 1)
    end
    if @course.save
      redirect_to @course, notice: 'Course was successfully created.'
    else
      render "new"
    end
  end

  def update
    @course = Course.find(params[:id])

    @course.teacher_id = params[:teacher][:user_id]

    if params[:term] == "Fall"
      @course.term = Date.new(Date.today.year, 8, 1)
    else
      @course.term = Date.new(Date.today.year, 1, 1)
    end
    if @course.update_attributes(params[:course])
      redirect_to @course, notice: 'Course was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url }
      format.json { head :no_content }
    end
  end

  def add
    @course = Course.find(params[:id])
    if @course.add_user(current_user)
      redirect_to root_path, notice: "Successfully Enrolled"
    else
      redirect_to root_path, notice: "Could Not Enroll"
    end
  end

  def drop
    @course = Course.find(params[:id])
    if @course.drop_user(current_user)
      redirect_to root_path, notice: "Successfully Dropped"
    else
      redirect_to root_path, notice: "Could Not Drop Class"
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
