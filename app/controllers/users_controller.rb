class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => "Signed up.  Check your email for verification."
    else
      render "new"
    end
  end
  
  # GET /users/:id/verify/:confirmation_code
  def verify
    @user = User.find(params[:id])
    logger.debug "conf code passed #{params[:confirmation_code]} checked against #{@user.confirmation_code}"
    if (@user.confirmed?)
      redirect_to root_url, :notice => 'Account already verified'
    elsif (@user.confirmation_code == params[:confirmation_code])
      @user.confirmed = true
      if @user.save
        redirect_to root_url, :notice => 'Account is verified!'
      else
        render "new"
      end      
    else
        redirect_to root_url, :notice => 'Verification code was invalid'
    end

    
  end
  
end
