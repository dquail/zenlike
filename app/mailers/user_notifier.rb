class UserNotifier < ActionMailer::Base
  default :from => 'no-reply@zenlike.me', :return_path => 'accounts@zenlike.me'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_notifier.verify_email.subject
  #
  
  def verify_email(user)
    @greeting = "Hi"
    @user = user
    mail to: user.email
  end

  def test_email
    mail to: "quail.david@gmail.com", subject: 'Rails test'
  end
end
