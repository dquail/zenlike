class AddDefaultTimeZoneToUser < ActiveRecord::Migration
  def change
    add_column :users, :default_time_zone, :string
  end
end
