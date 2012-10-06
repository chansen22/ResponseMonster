class PollsController < ApplicationController
  before_filter :authenticate

  def show
    @course = Course.find(params[:course_id])
    @survey = Survey.find(params[:survey_id])
    @poll = Poll.find(params[:id])
  end

  def new
    @course = Course.find(params[:course_id])
    @survey = Survey.find(params[:survey_id])
    @poll = Poll.new
  end

  def edit
    @course = Course.find(params[:course_id])
    @survey = Survey.find(params[:survey_id])
    @poll = Poll.find(params[:id])
  end

  def create
    @course = Course.find(params[:course_id])
    @survey = Survey.find(params[:survey_id])
    @poll = @survey.polls.create(params[:poll])
    if @poll.save
      redirect_to course_path(@course), notice: 'Poll was successfully created'
    else
      render action: "new"
    end
  end

  def update
    @course = Course.find(params[:course_id])
    @survey = Survey.find(params[:survey_id])
    @poll = Poll.find(params[:id])

    if @poll.update_attributes(params[:poll])
      redirect_to course_path(@course), notice: 'Poll was successfully updated'
    else
      render action: "edit"
    end
  end

  def destroy
    @course = Course.find(params[:course_id])
    @survey = Survey.find(params[:survey_id])
    @poll = Poll.find(params[:id])
    @poll.destroy
    redirect_to course_path(@course)
  end

  private

    def authenticate
      redirect_to signin_path unless signed_in?
    end
end
