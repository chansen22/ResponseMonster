class Response < ActiveRecord::Base
  belongs_to :assessment
  belongs_to :poll
  attr_accessible :choiceId, :short_answer, :times_submitted
  require 'debugger'

  def self.remove_old_responses(current_user, survey)
    current_user.responses.each do |response|
      survey.polls.each do |poll|
        if response.poll_id == poll.id
          response.delete
        end
      end
    end
  end

  def self.get_times_submitted(current_user, survey)
    poll = survey.polls.first
    times_submitted = 0
    current_user.responses.each do |response|
      if response.poll_id == poll.id
        times_submitted = response.times_submitted
      end
    end
    times_submitted
  end

  def  self.create_response(params, current_user, times_submitted)
    complete = true
    times_submitted += 1
    params.keys[2..-5].each do |key|
      if key =~ /short_answer/
        if !@response = Response.create(short_answer: params[key], times_submitted: times_submitted)
          complete = false
        end
        @poll = Poll.find(key.split("r")[2])
      else
        if !@response = Response.create(choiceId: params[key], times_submitted: times_submitted)
          complete = false
        end
        @poll = Poll.find(Answer.find(@response.choiceId).poll_id)
      end
      current_user.responses << @response
      @poll.responses << @response
    end
    complete
  end

  def self.grade_surveys(survey, current_user, assessment, old_assessment)
    is_finished = true
    number_correct = 0
    number_wrong = 0
    total_questions = survey.polls.count
    choices = []
    survey.polls.each do |poll|
      if poll.answer_type != "Multiple Choice"
        is_finished = false
      end
      poll.answers.each do |answer|
        choices << answer.id
      end
    end
    user_responses = current_user.responses.where(choiceId: choices)
    survey.polls.each do |poll|
      poll.answers.each do |answer|
        user_responses.each do |response|
          if answer.id == response.choiceId
            if answer.is_right
              number_correct += 1
              response.is_right = true
            else
              number_wrong += 1
              response.is_right = false
            end
          end
        end
      end
    end
    assessment.score = number_correct
    if is_finished
      assessment.total_points = number_correct + number_wrong
      assessment.is_graded = true
    end
    if assessment.save
      if old_assessment
        old_assessment.delete
      end
    end
  end
end
