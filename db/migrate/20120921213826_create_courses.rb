class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :title
      t.string :section
      t.datetime :term

      t.timestamps
    end
  end
end
