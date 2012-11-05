class CoursesController < ApplicationController
  before_filter :authenticate
  before_filter(only: [:show]) {|controller| controller.member_of_course(Course.find(params[:id]))}
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
    @surveys = @course.surveys.all
    @finished_surveys = []
    @surveys.each do |survey|
      poll = survey.polls.first
      if poll && poll.responses.any?
        poll.responses.each do |response|
          if response.user_id == current_user.id
            @finished_surveys << [ [ survey.id, survey.name, response.updated_at ] ]
          end
        end
      end
    end
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
end
