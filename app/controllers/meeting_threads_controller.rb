require 'json'

class MeetingThreadsController < ApplicationController
  
  load_and_authorize_resource :except => [:from_sendgrid]

  before_filter :check_subscription, :only => [:show, :index]
  
  # GET /meeting_threads
  # GET /meeting_threads.json
  def index

    #@meeting_threads = MeetingThread.all
    @meeting_threads = current_user.meeting_threads
    @current_user = current_user
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @meeting_threads }
    end
  end

  # GET /meeting_threads/1
  # GET /meeting_threads/1.json
  def show
    #@meeting_thread = MeetingThread.find(params[:id])
    if @current_user.is?("Turker")
      @calendar_guess = @meeting_thread.calendar_guesses.build 
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @meeting_thread }
    end
  end

  # GET /meeting_threads/new
  # GET /meeting_threads/new.json
  def new
    #@meeting_thread = MeetingThread.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @meeting_thread }
    end
  end

  # GET /meeting_threads/1/edit
  def edit
    #@meeting_thread = MeetingThread.find(params[:id])
  end

  # POST /meeting_threads
  # POST /meeting_threads.json
  def create
   # @meeting_thread = MeetingThread.new(params[:meeting_thread])

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
    #@meeting_thread = MeetingThread.find(params[:id])

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
   # @meeting_thread = MeetingThread.find(params[:id])
    @meeting_thread.destroy

    respond_to do |format|
      format.html { redirect_to meeting_threads_url }
      format.json { head :no_content }
    end
  end
  
  def from_sendgrid
    
    charsets = JSON.load(params[:charsets])
         
    #The params[:from] is often of the formant David Quail <quail.david@gmail.com>
    full_email = params[:from]
    email_address =""
    full_email.scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i) { |addr| email_address = addr } 
    
    
    user = User.find_by_email(email_address)
    if (user)
      logger.debug "Received request to schedule meeting from valid email address"     
      begin
        utf_html = params[:html].force_encoding(charsets['text']).encode('UTF-8')
        safe_html = ActionController::Base.helpers.sanitize(utf_html)
        logger.info "building meeting_thread"
        @meeting_thread = user.meeting_threads.build :headers => params[:headers], :text => params[:text].force_encoding(charsets['text']).encode('UTF-8'), :html => safe_html, :from => full_email, :to => params[:to], :cc => params[:cc], :subject => params[:subject]
        #save the meeting thread 
        logger.info "saving thread"
        @meeting_thread.save
        logger.info "saved thread"
        #Sending the user an email to say that it was received is in the MeetingThreadObserver
      rescue
        #MeetingRequestMailer.meeting_thread_exception(user).deliver
      end
    else
      #email user saying that they need to sign up for an account
      logger.debug "Receied request to schedule meeting from invalid email address"
      #MeetingRequestMailer.meeting_thread_invalid_email(email_address).deliver
    end

    
    render :json => { "message" => "OK" }, :status => 200
  end

  def check_subscription
    if (current_user.subscription.available_credits <=0)
      flash.alert = "You have no credits available.  Please upgrade your account."
    end
  end
  
end
