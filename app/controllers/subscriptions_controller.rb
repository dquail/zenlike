class SubscriptionsController < ApplicationController
  load_and_authorize_resource
  
  def new
    plan = Plan.find(params[:plan_id])

    @subscription = current_user.build_subscription
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

end
