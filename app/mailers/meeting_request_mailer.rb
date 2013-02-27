class MeetingRequestMailer < ActionMailer::Base
  default :from => 'Zenlike Assistant<no-reply@zenlike.me>', :return_path => 'accounts@zenlike.me'

  def meeting_thread_received(user)
    @user = user
    mail to: user.email
  end
  
  def meeting_thread_invalid_email(from)
    @from = from
    mail to: from
  end
  
  def meeting_thread_unconfirmed_email(user)
    @user = user
    mail to: user.email
  end
    
  def meeting_thread_exception(user)
    @user = user
    mail to: user.email
    mail to: 'david@zenlike.me'
  end

  def meeting_thread_failed(user)
    @user = user
    mail to: user.email
    mail to: 'david@zenlike.me'
  end
  
  def send_meeting_request(meeting_request, event)
    @meeting_request = meeting_request
    Rails.logger.debug "send_meeting_request to #{meeting_request.participants} "    
    attachments['event.ics'] = event.export()        
    mail to: meeting_request.participants
  end

end
