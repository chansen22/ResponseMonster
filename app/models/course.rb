class Course < ActiveRecord::Base
  attr_accessible :name, :section, :term, :title
end
