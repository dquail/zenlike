class AddTestFieldToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :last_4_digits, :string, :limit => 4
  end
end
