class MeetingThreadJobsController < ApplicationController
  
  #This is just a pass through controller
  #it's model is meeting_threads but this is the viewcontroller that turks will interact with
  #hence a different viewcontroller and view paradigm
  
  before_filter :authorize_turk
  # GET /meeting_threads
  # GET /meeting_threads.json
  def index
    
    @meeting_threads = @current_user.available_jobs

    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @meeting_threads }
    end
  end

protected
  def authorize_turk
    if (@current_user.type!= "Turker")
      redirect_to log_in_url, notice: "You must first log in to view jobs"
    end
  end
end
