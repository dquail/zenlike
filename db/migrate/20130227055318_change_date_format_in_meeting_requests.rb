class ChangeDateFormatInMeetingRequests < ActiveRecord::Migration
  def change
    remove_column :meeting_requests, :start_date_time
    remove_column :meeting_requests, :end_date_time    
    add_column :meeting_requests, :start_date_time, :datetime    
    add_column :meeting_requests, :end_date_time, :datetime    
  end
end
