class SubscriptionMailer < ActionMailer::Base
  
  default :from => 'Zenlike Assistant<no-reply@zenlike.me>', :return_path => 'accounts@zenlike.me'
  
  def payment_received(subscription)
    @user = subscription.user
    mail to: @user.email
  end
  
  def payment_denied(subscription)
    @user = subscription.user
    mail to: @user.email
  end
  
  def subscription_cancelled(subscription)
    @user = subscription.user
    mail to: @user.email    
  end    
  
  def subscription_created(subscription)
    @user = subscription.user
    mail to: @user.email
  end
  
  def subscription_overdue_reminder(subscription)
    @user = subscription.user
    mail to: @user.email
  end
end
