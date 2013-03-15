class AddTestFieldToSubscriptions < ActiveRecord::Migration
  def change
    remove_column :subscriptions, :last_4_digits
    add_column :subscriptions, :last_4_digits, :string, :limit => 4
  end
end
