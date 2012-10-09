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
    @course = Course.find(params[:responses].first[1][:course_id])
    @survey = Survey.find(params[:responses].first[1][:survey_id])
    @polls = @survey.polls
    params.keys[3..-4].each do |key|
      @response = Response.new(choiceId: key.split('=>')[-1][0])
      @response.save
      current_user.responses << @response
      @poll = Poll.find(Answer.find_by_id(@response.choiceId).poll_id)
      @poll.responses << @response
    end

    if current_user.responses.any?
      redirect_to summary_course_survey_path(@course, @survey), notice: 'Response was successfully created'
    else
      render action: "new", notice: "Could not save results"
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
