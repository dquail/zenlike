require 'ri_cal'

class MeetingRequest < ActiveRecord::Base
  attr_accessible :datetime, :description, :end_date_time, :location, :meeting_thread_id, :participants, :start_date_time, :time_zone
  belongs_to :meeting_thread
  
  

  def to_ics_test
    event = RiCal.Event do
          description "Test description"
          dtstart     DateTime.new(2001,2,3)
          dtend       DateTime.new(2001,2,4)
          location    "test location"
          add_attendee "david_quail@hotmail.com"

        end    
  end

  def to_ics
    meeting_request = self
    event = RiCal.Event do
          description meeting_request.description
          summary     "Zenlike meeting request"
          dtstart     meeting_request.start_date_time.strftime("%Y%m%dT%H%M%S")
          dtend       meeting_request.start_date_time.strftime("%Y%m%dT%H%M%S")
          location    meeting_request.location
          meeting_request.participants.split(/,\s*/).each do |email| 
            add_attendee email
          end
        end  
  end    
end
