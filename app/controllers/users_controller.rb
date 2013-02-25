class UsersController < ApplicationController
  skip_before_filter :authorize, :except => [:show, :edit]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Signed up.  Check your email for verification."
    else
      render "new"
    end
  end
  
  # GET /users/1/edit
  def edit
    @user = current_user
    if !@user
      flash[:notice] = 'You must first login'
      redirect_to root_url
    end
  end

  # GET /users/1/
  def show
    @user = current_user
    if !@user
      flash[:notice] = 'You must first login'
      redirect_to root_url
    end
  end
  
  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = current_user

    respond_to do |format|
      user_param = params[:user] || params[:turker]
      if @user.update_attributes(user_param)
        flash[:notice] = 'Successfully updated profile.'
        format.html { redirect_to account_url }
        format.xml  { head :ok }
      else
        flash[:error] = 'Failed updated profile.'        
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
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
