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
  
  def send_meeting_request(meeting_request)

    @meeting_request = meeting_request
    event = meeting_request.to_ics
    Rails.logger.debug "send_meeting_request to #{meeting_request.participants} "    

    attachments['event.ics'] = {:mime_type => 'text/calendar; charset=UTF-8;method=REQUEST', :content => event.export() }           
    #attachments['gmail.ics'] = {:mime_type => 'text/calendar; charset=UTF-8;method=REQUEST', :content => File.read("#{Rails.root}/public/assets/Gmail.ics") }           
    #attachments.inline['gmail.ics'] = {:mime_type => 'text/calendar; charset=UTF-8;method=REQUEST', :content => File.read("#{Rails.root}/public/assets/Gmail.ics") }               
    mail to: meeting_request.participants, :subject => "Meeting Request #{meeting_request.meeting_thread.subject}"
  end

  def test_send_meeting_request(meeting_request)

    attachments['gmail.ics'] = {:mime_type => 'text/calendar; charset=UTF-8;method=REQUEST', :content => File.read("#{Rails.root}/public/assets/Gmail.ics") }           
    mail(:to => "#{meeting_request.participants}", :subject => "iCalendar test") do |format|
      format.html
      format.text
      format.ics do
         @meeting_request = meeting_request
         event = meeting_request.to_ics

         #attachments['event.ics'] = {:mime_type => 'text/calendar; charset=UTF-8;method=REQUEST', :content => event.export() }           
         #attachments['gmail.ics'] = {:mime_type => 'text/calendar; charset=UTF-8;method=REQUEST', :content => File.read("#{Rails.root}/public/assets/Gmail.ics") }           
         render :text => File.read("#{Rails.root}/public/assets/Gmail.ics"), :layout => false
      end
    end
  end  
end
