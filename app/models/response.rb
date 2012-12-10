class Response < ActiveRecord::Base
  belongs_to :assessment
  belongs_to :poll
  attr_accessible :choiceId, :short_answer, :times_submitted, :points, :poll_id

#  def self.create_responses(params, user, assessment)
#    complete = true
#    params.keys[2..-5].each do |key|
#      if key =~ /short_answer/
#        if !@response = Response.create(short_answer: params[key])
#          complete = false
#        end
#        @poll = Poll.find(key.split("r")[2])
#      else
#        if !@response = Response.create(choiceId: params[key])
#          complete = false
#        end
#        @poll = Poll.find(Answer.find(@response.choiceId).poll_id)
#      end
#      assessment.responses << @response
#      @poll.responses << @response
#    end
#    complete
#  end
end
