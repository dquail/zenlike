Stripe.api_key = "sk_test_hWcAZqDLEpB3ne8JEQdrQ8vM"
STRIPE_PUBLIC_KEY = "pk_test_bsLjkPKn3lNoDcVIpdYHvqeD"

StripeEvent.setup do
  subscribe 'charge.failed' do |event|
    Rails.logger.info "Charge failed event from stripe"
    subscription_from_event(event).charge_failed(event)
    
  end
  
  subscribe 'charge.succeeded' do |event|
    Rails.logger.info "Charge succeeded event from stripe"    
    subscription_from_event(event).charge_succeeded(event)
  end

  
end


private 
def subscription_from_event(event)
  subscription = Subscription.find_by_stripe_customer_token(event.data.object.customer)
end