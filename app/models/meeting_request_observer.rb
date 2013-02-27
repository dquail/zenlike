
class MeetingRequestObserver < ActiveRecord::Observer
  
  def after_save(meeting_request)
    Rails.logger.debug "CalendarRequestObserver with participants #{meeting_request.participants}"
    
    #Send the email out

    
    MeetingRequestMailer.send_meeting_request(meeting_request).deliver
  end
  
  
end