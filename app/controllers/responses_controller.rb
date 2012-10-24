class ResponsesController < ApplicationController
  
  def index
    @responses = Response.all

    respond_to do |format|
      format.html 
      format.json { render json: @responses }
    end
  end

  def show
    @response = Response.find(params[:id])
  end

  def new
    @response = Response.new
  end

  def edit
    @response = Response.find(params[:id])
  end

  def create
  @survey = Survey.find(params[:survey])
    @course = Course.find(@survey.course_id)
    times_submitted = Response.get_times_submitted(current_user, @survey)
    Response.remove_old_responses(current_user, @survey)
    if params.keys.count >= 7
      if Response.create_response(params, current_user, times_submitted)
        redirect_to summary_course_survey_path(@course, @survey), notice: 'Response was successfully created'
      else
        redirect_to course_survey_path(@course, @survey), notice: "Response was not successfully created"
      end
    else
      redirect_to course_survey_path(@course, @survey), notice: "Please answer at least one question"
    end
  end

  def update
    @response = Response.find(params[:id])

    respond_to do |format|
      if @response.update_attributes(params[:response])
        format.html { redirect_to @response, notice: 'Response was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  @response = Response.find(params[:id])
    @response.destroy

    respond_to do |format|
      format.html { redirect_to responses_url }
      format.json { head :no_content }
    end
  end
end
