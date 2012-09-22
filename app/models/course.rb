class Course < ActiveRecord::Base
  has_and_belongs_to_many :users
  attr_accessible :name, :section, :term, :title

  validates( :name, :title, :section, :term, presence: true )

  def add_user(user)
    self.users << user
  end

  def drop_user(user)
    self.users.delete(user)
  end
end
