class UserObserver < ActiveRecord::Observer
  def after_create(user)
    #Create a confirmation_code and send an email to the user
    #TODO - Create a real confirmation code
    user.confirmation_code = "test"
    UserNotifier.verify_email(user).deliver
  end
  
  #Todo Add an observer when email field changes
  
  
end