class AssessmentsController < ApplicationController
  require 'debugger'
  before_filter :authenticate
  before_filter(only: [:new]) { |controller| controller.check_activated(Survey.find(params[:survey_id])) }
  before_filter(only: [:new]) { |controller| controller.check_attempts(Survey.find(params[:survey_id])) }
  before_filter(only: [:index]) { |controller| controller.check_permissions(Course.find(params[:course_id])) }

  def index
    @assessments = Assessment.where(survey_id: params[:survey_id])
    @course = Course.find(params[:course_id])
    @survey = Survey.find(params[:survey_id])
  end

  def show
    @assessment = Assessment.find(params[:id])
    @survey = @assessment.survey
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
    if current_user.assessments.where(survey_id: @survey).length >= @survey.attempts_allowed
      redirect_to course_path(@course), notice: "You cannot take this quiz anymore times."
      return
    end
    @assessment = current_user.assessments.new(params[:assessment])
    @assessment.times_submitted = current_user.assessments.where(survey_id: @survey).length + 1
    @assessment.survey = @survey
    # Need to save once so that all the ids are created before grading
    if @assessment.save
      @assessment.grade
      @assessment.save
      redirect_to course_path(@course), notice: "Assessment was successfully submitted!"
    else
      redirect_to course_path(@course), notice: "There were some errors submitting your Assessment."
    end
  end

  def edit
    @assessment = Assessment.find(params[:id])
    @survey = Survey.find(params[:survey_id])
    @course = Course.find(params[:course_id])
  end

  def update
    @assessment = Assessment.find(params[:id])
    @assessment.score = params[:new_score][:score]
    @course = Course.find(params[:course_id])
    if @assessment.save
      redirect_to course_path(@course), notice: "Assessment was successfully submitted!"
    else
      redirect_to course_path(@course), notice: "There were some errors submitting your Assessment."
    end
  end
end
