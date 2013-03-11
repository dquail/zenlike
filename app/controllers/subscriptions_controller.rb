class SubscriptionsController < ApplicationController
  load_and_authorize_resource
  
  def new
    if (params[:plan_id])
      plan = Plan.find(params[:plan_id])
    elsif (params[:plan_name])
      plan = Plan.find_by_name(params[:plan_name])
    end
    
    
    @subscription = current_user.subscription || current_user.build_subscription
    @subscription.plan = plan
  end

  def create
    @subscription = Subscription.new(params[:subscription])
    @subscription.user = @current_user
    if @subscription.save_with_payment
      redirect_to @subscription, :notice => "Thank you for subscribing!"
    else
      render :new
    end
  end

  def show
    @subscription = Subscription.find(params[:id])
  end
  
  def edit
    plan = Plan.find(params[:plan_id])
    @subscription = current_user.subscription
    @subscription.plan = plan
    if @subscription.save_with_payment
        redirect_to @subscription, :notice => "Thank you for subscribing!"
      else
        render :new
    end
  end

  def update_plan
    #todo - update the plan
    logger.debug "subscriptions_controller.update_plan"
  end
  
  def update_card
    logger.info "subscriptions_controller.update_card"

    if (@current_user.subscription)
      @subscription = @current_user.subscription
      logger.info "setting the stripe_card_token of model to #{params[:subscription][:stripe_card_token]}"
      @subscription.stripe_card_token = params[:subscription][:stripe_card_token]

      if @subscription.save_with_payment
          redirect_to @subscription, :notice => "Thank you for subscribing!"
        else
          logger.info "unable to update card"
          flash.alert = 'Unable to update card.'
      end

    else
      redirect_to @subscription, :error => "Can not update card for non-existant subscription."          
    end
  end
  
end
