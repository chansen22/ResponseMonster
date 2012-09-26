class SurveysController < ApplicationController

  def index
    @surveys = Survey.all

    respond_to do |format|
      format.html
      format.json { render json: @surveys }
    end
  end

  def show
    @survey = Survey.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @survey }
    end
  end

  def new
    @survey = Survey.new
    if params[:course].nil?
      redirect_to root_path, notice: "Surveys must be created from inside courses"
    else
      course = Course.find_by_id(params[:course])
      @course_id = course.id
      if course.teacher_id != current_user.id
        redirect_to root_path, notice: "You are not a teacher of this class"
      end
    end
  end

  def edit
    @survey = Survey.find(params[:id])
  end

  def create
    @survey = Survey.new(params[:survey])

    respond_to do |format|
      if @survey.save
        format.html { redirect_to @survey, notice: 'Survey was successfully created.' }
        format.json { render json: @survey, status: :created, location: @survey }
      else
        format.html { render action: "new" }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @survey = Survey.find(params[:id])

    respond_to do |format|
      if @survey.update_attributes(params[:survey])
        format.html { redirect_to @survey, notice: 'Survey was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @survey = Survey.find(params[:id])
    @survey.destroy

    respond_to do |format|
      format.html { redirect_to surveys_url }
      format.json { head :no_content }
    end
  end
end
