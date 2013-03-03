class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :default_time_zone  
      t.timestamps
    end
  end
end
