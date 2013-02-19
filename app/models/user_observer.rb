
class UserObserver < ActiveRecord::Observer
  def after_create(user)
    #Create a confirmation_code and send an email to the user
    #TODO - Create a real confirmation code
    Rails.logger.debug "UserObserver for email: #{user.email}"
    user.confirmation_code = SecureRandom.hex(16)
    user.save!
    UserNotifier.verify_email(user).deliver
  end
  
  #Todo Add an observer when email field changes
  
  
end