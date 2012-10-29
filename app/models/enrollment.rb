class Enrollment < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  attr_accessible :course_id, :grade, :user_id
end
