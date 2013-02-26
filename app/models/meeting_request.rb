class MeetingRequest < ActiveRecord::Base
  attr_accessible :datetime, :description, :end_date_time, :location, :meeting_thread_id, :participants, :start_date_time, :time_zone
  belongs_to :meeting_thread
  
end
