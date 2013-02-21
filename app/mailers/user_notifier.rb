class UserNotifier < ActionMailer::Base
  default :from => 'Zenlike Accounts<no-reply@zenlike.me>', :return_path => 'accounts@zenlike.me'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_notifier.verify_email.subject
  #
  
  def verify_email(user)
    @user = user
    mail to: user.email
  end

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
    mail to: david@zenlike.me
  end
  
  def test_email
    mail to: "quail.david@gmail.com", subject: 'Rails test'
  end
  
end
