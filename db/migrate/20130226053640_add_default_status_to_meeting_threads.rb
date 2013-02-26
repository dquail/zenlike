class AddDefaultStatusToMeetingThreads < ActiveRecord::Migration
  def change
    change_column :meeting_threads, :status, :string, :default => "open"    
  end
end
