class AssessmentsController < ApplicationController
  require 'debugger'
  before_filter :authenticate
  before_filter(only: [:new]) { |controller| controller.check_activated(Survey.find(params[:survey_id])) }
  before_filter(only: [:new]) { |controller| controller.check_attempts(Survey.find(params[:survey_id])) }
  before_filter(only: [:new]) { |controller| controller.check_password(Survey.find(params[:survey_id])) }
  before_filter(only: [:index]) { |controller| controller.check_permissions(Course.find(params[:course_id])) }

  def show
  end

  def new
    @assessment = Assessment.new
    @survey = Survey.find(params[:survey_id])
    @course = Course.find(params[:course_id])
    @times_submitted = @survey.assessments.where(user_id: current_user.id).length
  end

  def create
    @survey = Survey.find(params[:survey_id])
    @course = Course.find(params[:course_id])
    @assessment = current_user.assessments.new(params[:assessment])
    @assessment.times_submitted = current_user.assessments.where(survey_id: @survey).length + 1
    @assessment.survey = @survey
    if @assessment.save
      redirect_to course_path(@course), notice: "Assessment was successfully submitted!"
    else
      render new_course_survey_path(@course), notice: "There were some errors submitting your Assessment."
    end
  end

end
