class SurveysController < ApplicationController
  before_filter :authenticate
  before_filter(only: [:show]) { |controller| controller.check_activated(Survey.find(params[:id])) }
  before_filter(only: [:show]) { |controller| controller.check_attempts(Survey.find(params[:id])) }
  before_filter(only: [:show]) { |controller| controller.check_password(Survey.find(params[:id])) }
  before_filter(except: [:show, :summary, :login, :check]) { |controller| controller.check_permissions(Course.find(params[:course_id])) }
  before_filter :admin_user, only: [:index]

  def show
    @survey = Survey.find(params[:id])
    @course = @survey.course
    @old_submitted = Response.get_times_submitted(current_user, @survey)
    @responses = []
    @survey.polls.each do |poll|
      poll.answers.each do |answer|
        @responses << Response.new
      end
    end
  end

  def new
    @survey = Survey.new
    @course = Course.find(params[:course_id])
  end

  def edit
    @survey = Survey.find(params[:id])
    @course = Course.find(params[:course_id])
  end

  def create
    @course = Course.find(params[:course_id])
    @survey = @course.surveys.new(params[:survey])

    if @survey.save
      redirect_to course_path(@course), notice: "Survey was successfully created"
    else
      render new_course_survey_path(@course), notice: "There were some errors"
    end
  end

  def update
    @survey = Survey.find(params[:id])
    @course = @survey.course

    if @survey.update_attributes(params[:survey])
      redirect_to course_path(@course), notice: 'Survey was successfully updated'
    else
      render "edit", notice: "There were some errors"
    end
  end

  def destroy
    @survey = Survey.find(params[:id])
    @course = @survey.course

    if @survey.destroy
      redirect_to course_path(@course), notice: "Survey successfully deleted"
    else
      redirect_to course_path(@course), notice: "Survey was not deleted"
    end
  end

  def activate
    @survey = Survey.find(params[:id])
    @course = @survey.course
    if @survey.toggle_survey(@survey)
      redirect_to course_path(@course), notice: "Activated survey"
    else
      redirect_to course_path(@course), notice: "Could not activate survey"
    end
  end

  def deactivate
    @survey = Survey.find(params[:id])
    @course = @survey.course
    if @survey.toggle_survey(@survey)
      redirect_to course_path(@course), notice: "Deactivated survey"
    else
      redirect_to course_path(@course), notice: "Could not deactivate survey"
    end
  end

  def summary
    @survey = Survey.find(params[:id])
    @course = @survey.course
    @polls = @survey.polls.all
    @responses = current_user.responses.all
  end

  def login
    @survey = Survey.find(params[:id])
    @course = @survey.course
    if @course.teacher_id == current_user.id || is_admin?
      redirect_to course_survey_path(@course, @survey)
    end
  end

  def grade
    @survey = Survey.find(params[:id])
    @course = @survey.course
    @assessments = @survey.assessments
  end

  def check
    @survey = Survey.find(params[:id])
    @course = @survey.course
    if params["pass"][:password] && params["pass"][:password] == @survey.password
      redirect_to course_survey_path(@course, @survey, pass: params["pass"][:password])
    else
      flash.now[:error] = "The password you entered was incorrect"
      render "login"
    end
  end
end
