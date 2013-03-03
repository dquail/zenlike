class MeetingThreadJobsController < ApplicationController
  
  #This is just a pass through controller
  #it's model is meeting_threads but this is the viewcontroller that turks will interact with
  #hence a different viewcontroller and view paradigm

  before_filter :authorize_turker
  
  # GET /meeting_threads_jobs
  # GET /meeting_thread_jobs.json
  def index
    
    @meeting_threads = @current_user.available_jobs
    
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @meeting_threads }
    end
  end


  # GET /meeting_thread_jobs/1
  # GET /meeting_thread_jobs/1.json
  def show
    @meeting_thread = MeetingThread.find(params[:id])
    @calendar_guess = @meeting_thread.calendar_guesses.build 
    @calendar_guess.time_zone = @meeting_thread.user.default_time_zone
    #@calendar_guess.description = @meeting_thread.html


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @meeting_thread }
    end
  end

protected
  def authorize_turker
    authorize! :create, CalendarGuess
  end
end
