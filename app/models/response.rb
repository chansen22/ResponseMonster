class Response < ActiveRecord::Base
  belongs_to :users
  belongs_to :polls
  attr_accessible :choiceId, :short_answer, :times_submitted

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
end
