
class UserObserver < ActiveRecord::Observer
  
  def after_create(user)
    Rails.logger.debug "UserObserver.after_save"
    
    #default to have a user have a Free plan
    if (user.plan)
      Rails.logger.debug "Don't have to update the plan.  Already specified"
    else
      plan = Plan.find_by_name('Free')
      user.plan = plan
    end
    
    #default to have a user have a regular role
    Rails.logger.debug "Setting the role"
        
  end
  
end