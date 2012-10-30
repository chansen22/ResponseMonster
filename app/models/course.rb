class Course < ActiveRecord::Base
  has_many :enrollments, dependent: :destroy
  has_many :users, through: :enrollments
  has_many :surveys, dependent: :destroy
  attr_accessible :name, :section, :term, :title, :teacher_id

  validates( :name,  :title, :section, presence: true )

  def add_user(user)
    self.users << user
  end

  def drop_user(user)
    self.users.delete(user)
  end
end
