class Assessment < ActiveRecord::Base
  belongs_to :user
  belongs_to :survey
  has_many :responses
end
