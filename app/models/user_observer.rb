
class UserObserver < ActiveRecord::Observer
  
  def after_create(user)
    Rails.logger.debug "UserObserver.after_save"
    
    #default to have a user have a Free plan
    if (user.plan)
      Rails.logger.debug "Don't have to update the plan.  Already specified"
    else
      sub = user.build_subscription
      sub.plan = Plan.find_by_name('Free')
      customer = Stripe::Customer.create(description: user.email, plan: sub.plan.stripe_id)
      sub.stripe_customer_token = customer.id      
      sub.save!
    end
    
    #default to have a user have a regular role
    Rails.logger.debug "Setting the role"
        
  end
  
end