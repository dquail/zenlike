class RemoveCreditsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :available_credits
  end
end
