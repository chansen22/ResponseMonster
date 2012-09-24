class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string  :name
      t.string  :title
      t.string  :section
      t.date    :term
      t.integer :teacher_id

      t.timestamps
    end
  end
end
