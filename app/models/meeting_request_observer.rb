
class MeetingRequestObserver < ActiveRecord::Observer
  
  def after_create(meeting_request)
    Rails.logger.debug "CalendarRequestObserver with participants #{meeting_request.participants}"
    
    #Send the email out

    meeting_request.send_to_participants
    

  end
  
  
end