
class MeetingThreadObserver < ActiveRecord::Observer
  
  def after_save(meeting_thread)
    Rails.logger.debug "MeetingThreadObserver.after_save"
    user = meeting_thread.user

    if (meeting_thread.status == 'failed')
      Rails.logger.debug "Failed to create a meeting_request"
      MeetingRequestMailer.meeting_thread_failure(user).deliver
    else
      meeting_thread.user.subscription.available_credits-=1  
      meeting_thread.user.subscription.save!
      if meeting_thread.user.subscription.available_credits > 0
        MeetingRequestMailer.meeting_thread_received(meeting_thread.user).deliver              
      else 
        SubscriptionMailer.subscription_overdue_reminder(meeting_thread.user.subscription).deliver
      end
    end
  end
  
  def after_create(meeting_thread)
    Rails.logger.debug "MeetingThreadObserver.after_create"    
  end
  
end