class Subscription < ActiveRecord::Base
  belongs_to :plan
  belongs_to :user
  validates_presence_of :plan_id
  validates_presence_of :user_id
  
  #TODO - Not mass accessible
  attr_accessible :stripe_card_token, :plan_id
  attr_accessor :stripe_card_token
  
  def save_with_payment
    if valid?
      if stripe_customer_token
        logger.debug "Updating card of existing stripe user"
        customer = Stripe::Customer.retrieve(stripe_customer_token)
        customer.card = stripe_card_token
        customer.save        
      else
        logger.debug "Creating new stripe user"
        customer = Stripe::Customer.create(description: user.email, plan: plan.stripe_id, card: stripe_card_token)
      end

      self.stripe_customer_token = customer.id     
      self.last_4_digits = customer.active_card.last4         
      save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end

  
  def update_plan
    #TODO - just stubbed in
  end


end
