class Course < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :surveys
  attr_accessible :name, :section, :term, :title, :teacher_id

  validates( :name,  :title, :section, presence: true )

  def add_user(user)
    self.users << user
  end

  def drop_user(user)
    self.users.delete(user)
  end
end
