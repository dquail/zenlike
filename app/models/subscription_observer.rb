
class SubscriptionObserver < ActiveRecord::Observer
  def after_create(subscription)
    Rails.logger.debug "SubscriptionObserver after_create observer"
    subscription.available_credits = subscription.plan.credits
  end
end
