class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean
    add_column :users, :teacher, :boolean
    add_index :users, :email, :unique => true
  end
end
