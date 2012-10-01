class Poll < ActiveRecord::Base
  belongs_to      :survey
  attr_accessible :question, :type
end
