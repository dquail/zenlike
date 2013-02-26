
class MeetingThreadObserver < ActiveRecord::Observer
  
  def after_save(meeting_thread)
    Rails.logger.debug "MeetingThreadObserver.after_save"
    user = meeting_thread.user
    
    if (meeting_thread.status == 'failed')
      Rails.logger.debug "Failed to create a meeting_request"
      MeetingRequestMailer.meeting_thread_failure(user).deliver
    end
  end
  
  def after_create(meeting_thread)
    Rails.logger.debug "MeetingThreadObserver.after_create"
    MeetingRequestMailer.meeting_thread_received(meeting_thread.user).deliver              
  end
  
end