class AddLast4DigitsToSubscriptions < ActiveRecord::Migration
  def change
    remove_column :subscriptions, :available_credits
    add_column :subscriptions, :available_credits, :integer, :default => 3    
  end
end
