Stripe.api_key = "sk_test_hWcAZqDLEpB3ne8JEQdrQ8vM"
STRIPE_PUBLIC_KEY = "pk_test_bsLjkPKn3lNoDcVIpdYHvqeD"

StripeEvent.setup do
  subscribe 'charge.failed' do |event|
    subscription_from_event(event).charge_failed(event)
    
  end
  
  subscribe 'charge.succeeded' do |event|
    subscription_from_event(event).charge_succeeded(event)
  end

  subscribe 'customer.subscription.created' do |event|
    subscription_from_event(event).customer_subscription_created_or_updated
  end
  
  subscribe 'customer.subscription.updated' do |event|
    subscription_from_event(event).customer_subscription_created_or_updated
  end
  
end


private 
def subscription_from_event(event)
  subscription = Subscription.find_by_stripe_customer_token(event.data.object.customer)
end