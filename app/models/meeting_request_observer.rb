require 'ri_cal'
  
class MeetingRequestObserver < ActiveRecord::Observer
  
  def after_save(meeting_request)
    Rails.logger.debug "CalendarRequestObserver with participants #{meeting_request.participants}"
    
    #Send the email out
    event = RiCal.Event do
          description meeting_request.description
          dtstart     meeting_request.start_date_time.strftime("%Y%m%dT%H%M%S")
          dtend       meeting_request.start_date_time.strftime("%Y%m%dT%H%M%S")
          location    meeting_request.location
          meeting_request.participants.split(/,\s*/).each do |email| 
            add_attendee email
          end
        end    
    
    MeetingRequestMailer.send_meeting_request(meeting_request, event).deliver
  end
  
  
end