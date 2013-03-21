class CreateGoogleUsers < ActiveRecord::Migration
  def change
    create_table :google_users do |t|
      t.string :email
      t.string :google_access_token
      t.string :google_refresh_token
      t.integer :google_expires_at

      t.timestamps
    end
  end
end
