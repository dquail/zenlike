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

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription = Subscription.find(params[:id])
    
    @subscription.destroy

    respond_to do |format|
      format.html { redirect_to meeting_threads_url }
      format.json { head :no_content }
    end
  end
  
  def update_plan
    if (@current_user.subscription)
      @subscription = @current_user.subscription
      if (params[:subscription]) && params[:subscription][:plan_id]
        plan = Plan.find(params[:subscription][:plan_id])
      else
        plan = Plan.find_by_name(params[:plan_name])
      end
      
      @subscription.plan = plan

      if @subscription.update_plan
          redirect_to @subscription, :notice => "Thank you for subscribing!"
        else
          flash.alert = 'Unable to update subscription plan.'
      end

    else
      redirect_to @subscription, :error => "Can not update plan for non-existant subscription."          
    end    
  end
  
  def update_card
  
    if (@current_user.subscription)
      @subscription = @current_user.subscription
      @subscription.stripe_card_token = params[:subscription][:stripe_card_token]

      if @subscription.save_with_payment
          redirect_to @subscription, :notice => "Thank you for subscribing!"
        else
          flash.alert = 'Unable to update card.'
      end

    else
      redirect_to @subscription, :error => "Can not update card for non-existant subscription."          
    end
  end
  
end
