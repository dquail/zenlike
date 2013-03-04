class AddAvailabileCreditsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :available_credits, :integer, :default => 3
  end
end
