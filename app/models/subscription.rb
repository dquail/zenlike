class Subscription < ActiveRecord::Base
  belongs_to :plan
  belongs_to :user
  validates_presence_of :plan_id
  validates_presence_of :user_id
  
  #TODO - Not mass accessible
  attr_accessible :stripe_card_token, :plan_id
  attr_accessor :stripe_card_token
  
  def save_with_payment
    #TODO - Check to see if the user already has a payment set up.  If they do, we just need to 
    #update the existing payment plan.  Otherwise we need to create a new one
    if valid?
      if stripe_customer_token
        customer = Stripe::Customer.retrieve(stripe_customer_token)
        customer.update_subscription(plan: plan.stripe_id, prorate:true)
      else
        customer = Stripe::Customer.create(description: user.email, plan: plan.stripe_id, card: stripe_card_token)
      end
      self.stripe_customer_token = customer.id      
      save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
end
