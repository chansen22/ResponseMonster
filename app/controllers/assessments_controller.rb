class AssessmentsController < ApplicationController
  require 'debugger'
  before_filter :authenticate
  before_filter(only: [:show]) { |controller| controller.check_activated(Survey.find(params[:id])) }
  before_filter(only: [:show]) { |controller| controller.check_attempts(Survey.find(params[:id])) }
  before_filter(only: [:show]) { |controller| controller.check_password(Survey.find(params[:id])) }
  before_filter(except: [:show, :summary, :login, :check]) { |controller| controller.check_permissions(Course.find(params[:course_id])) }
  before_filter :admin_user, only: [:index]

  def show
  end

  def new
    @assessment = Assessment.new
    @survey = Survey.find(params[:survey_id])
    @course = Course.find(params[:course_id])
  end

  def create
    debugger
    @success=false
    @survey = Survey.find(params[:survey_id])
    @course = Course.find(params[:course_id])
    @assessment = current_user.assessments.new(params[:assessment])
    if @assessment.save
      @success=true
    else
      @success=false
    end
    @success
  end

end
