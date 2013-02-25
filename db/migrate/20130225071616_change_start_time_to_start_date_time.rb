class ChangeStartTimeToStartDateTime < ActiveRecord::Migration
  def change
    rename_column :calendar_guesses, :start_time, :start_date_time
    rename_column :calendar_guesses, :end_time, :end_date_time    
  end
end
