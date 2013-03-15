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
  
  subscribe 'invoiceitem.created' do |event|
    Rails.logger.info 'Invoice created'
    subscription = subscription_from_event(event)
    if (subscription.plan.name == 'Free')
      subscription.free_plan_invoiced
    end
  end
  
end


private 
def subscription_from_event(event)
  Rails.logger.info "customer data: #{event.data.object.customer}"
  
  subscription = Subscription.find_by_stripe_customer_token(event.data.object.customer)
  if (subscription)
    Rails.logger.info "found a subscription matching customer"
    return subscription
  else
    return nil
  end

end