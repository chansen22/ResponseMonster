class SurveysController < ApplicationController

  def show
    @survey = Survey.find(params[:id])
    @course = @survey.course
  end

  def new
    @survey = Survey.new
  end

  def edit
    @survey = Survey.find(params[:id])
  end

  def create
    @course = Course.find(params[:course_id])
    @survey = @course.surveys.create(params[:survey])

    if @survey.save
      redirect_to course_path(@course), notice: "Survey was successfully created"
    else
      render new_course_survey_path(@course.id)
    end
  end

  def update
    @survey = Survey.find(params[:id])
    @course = @survey.course

    if @survey.update_attributes(params[:survey])
      redirect_to course_path(@course), notice: 'Survey was successfully updated'
    else
      render action: "edit", notice: "There were some errors"
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
end
