class RemovePlanFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :plan    
  end
end
