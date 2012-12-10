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
    @assessment = Assessment.create_assessment(current_user, 0, @survey)
    #TODO: How can we do this better
    if params.keys.count >= 7
      if Response.create_responses(params, current_user, @assessment)
#        Assessment.taken(@assessment, @old_assessment)
#        Assessment.remove_old_assessment(@old_assessment)
        Assessment.grade(@assessment)
        redirect_to summary_course_survey_path(@survey.course, @survey), notice: "#{@survey.name} was 
        successfully saved"
      else
        redirect_to course_survey_path(@survey.course, @survey), notice: "#{@survey.name} was 
        not successfully saved"
      end
    else
      redirect_to course_survey_path(@survey.course, @survey), notice: "Please answer at least one
      question"
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
