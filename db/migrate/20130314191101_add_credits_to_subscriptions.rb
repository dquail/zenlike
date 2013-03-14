class AddCreditsToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :available_credits, :integer, :default => 3
  end
end
