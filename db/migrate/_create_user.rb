class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |k|
      k.string :email
      k.string :first_name
      k.string :last_name
      k.string :password
      
      t.timestamps
    end
  end
end
