class MeetingThreadsController < ApplicationController
  
  skip_before_filter :authorize, :only => [:from_sendgrid]
  # GET /meeting_threads
  # GET /meeting_threads.json
  def index
    #@meeting_threads = MeetingThread.all

    @meeting_threads = @current_user.meeting_threads
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @meeting_threads }
    end
  end

  # GET /meeting_threads/1
  # GET /meeting_threads/1.json
  def show
    @meeting_thread = MeetingThread.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @meeting_thread }
    end
  end

  # GET /meeting_threads/new
  # GET /meeting_threads/new.json
  def new
    @meeting_thread = MeetingThread.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @meeting_thread }
    end
  end

  # GET /meeting_threads/1/edit
  def edit
    @meeting_thread = MeetingThread.find(params[:id])
  end

  # POST /meeting_threads
  # POST /meeting_threads.json
  def create
    @meeting_thread = MeetingThread.new(params[:meeting_thread])

    respond_to do |format|
      if @meeting_thread.save
        format.html { redirect_to @meeting_thread, notice: 'Meeting thread was successfully created.' }
        format.json { render json: @meeting_thread, status: :created, location: @meeting_thread }
      else
        format.html { render action: "new" }
        format.json { render json: @meeting_thread.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /meeting_threads/1
  # PUT /meeting_threads/1.json
  def update
    @meeting_thread = MeetingThread.find(params[:id])

    respond_to do |format|
      if @meeting_thread.update_attributes(params[:meeting_thread])
        format.html { redirect_to @meeting_thread, notice: 'Meeting thread was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @meeting_thread.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meeting_threads/1
  # DELETE /meeting_threads/1.json
  def destroy
    @meeting_thread = MeetingThread.find(params[:id])
    @meeting_thread.destroy

    respond_to do |format|
      format.html { redirect_to meeting_threads_url }
      format.json { head :no_content }
    end
  end
  
  def from_sendgrid
    
    #render :json => { "message" => "OK" }, :status => 200
    #return
    logger.debug "Received request from sendgrid"

    #populate the meeting thread with the params    
    
    #The params[:from] is often of the formant David Quail <quail.david@gmail.com>
    full_email = params[:from]
    email_address =""
    full_email.scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i) { |addr| email_address = addr } 
    
    
    user = User.find_by_email(email_address)
    if (user)
      if (user.confirmed?)
        logger.debug "Receied request to schedule meeting from valid email address"      
        #@meeting_thread = user.meeting_threads.build :headers => params[:headers], :text => params[:text], :from => full_email, :to => params[:to], :cc => params[:cc], :subject => params[:subject]
        #@meeting_thread = user.meeting_threads.build :text => params[:text].encode('UTF-8'), :from => full_email, :to => params[:to], :cc => params[:cc], :subject => params[:subject]
        raw_text = params[:text]
        raw_text.force_encoding('windows-1252')
        text_utf8 = raw_text.encode('UTF-8')
        @meeting_thread = user.meeting_threads.build :text => text_utf8, :from => full_email, :to => params[:to], :cc => params[:cc], :subject => params[:subject]

        #save the meeting thread 
        @meeting_thread.save

        #email user saying that a request will be created shortly
        UserNotifier.meeting_thread_received(user).deliver
      else
        logger.debug "Received a request to schedule meeting from an unconfirmed address"
        UserNotifier.meeting_thread_unconfirmed_email(user).deliver
      end
    else
      #email user saying that they need to sign up for an account
      logger.debug "Receied request to schedule meeting from invalid email address"
      UserNotifier.meeting_thread_invalid_email(email_address).deliver
    end

    
    render :json => { "message" => "OK" }, :status => 200
  end
  
end
