class AddStatusToMeetingThreads < ActiveRecord::Migration
  def change
    add_column :meeting_threads, :status, :string    
  end
end
