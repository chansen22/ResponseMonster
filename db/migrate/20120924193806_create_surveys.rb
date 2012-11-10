class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :name
      t.datetime :start_time
      t.datetime :end_time
      t.integer :total_points
      t.boolean :is_active, default: false
      t.integer :attempts_allowed
      t.string :password

      t.timestamps
    end
  end
end
