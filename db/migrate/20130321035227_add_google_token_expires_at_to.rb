class AddGoogleTokenExpiresAtTo < ActiveRecord::Migration
  def change
    add_column :users, :google_expires_at, :integer
  end
end
