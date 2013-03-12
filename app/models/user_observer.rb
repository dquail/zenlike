
class UserObserver < ActiveRecord::Observer
  
  def after_create(user)
    Rails.logger.debug "UserObserver.after_save"
    if (user.plan)
      Rails.logger.debug "Don't have to update the plan.  Already specified"
    else
      plan = Plan.find_by_name('Free')
      user.plan = plan
    end
  end
  
end