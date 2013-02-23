class CalendarGuessesController < ApplicationController
  skip_before_filter :authorize, :only => [:from_sendgrid]
  # GET /callendar_guesses.html
  # GET /meeting_threads.json
  def index
    #@meeting_threads = MeetingThread.all

    @calendar_guesses = @current_user.calendar_guesses
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @calendar_guesses }
    end
  end

  # GET /calendar_guesses/1
  # GET /calendar_guesses/1.json
  def show
    @calendar_guess = CalendarGuess.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @calendar_guess }
    end
  end

  # GET /calendar_guesses/new
  # GET /calendar_guesses/new.json
  def new
    @calendar_guess = CalendarGuess.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @calendar_guess }
    end
  end

  # GET /calendar_guesses/1/edit
  def edit
    @calendar_guess = CalendarGuess.find(params[:id])
    @calendar_guess.turker = @current_user
  end

  # POST /calendar_guess
  # POST /calendar_guess.json
  def create
    @calendar_guess = CalendarGuess.new(params[:calendar_guess])
    
    respond_to do |format|
      if @calendar_guess.save
        format.html { redirect_to meeting_thread_jobs_url }
        format.json { render json: @calendar_guess, status: :created, location: @calendar_guess }
      else
        format.html { render action: "new" }
        format.json { render json: @calendar_guess.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /calendar_guess/1
  # PUT /calendar_guess/1.json
  def update
    @calendar_guess = CalendarGuess.find(params[:id])

    respond_to do |format|
      if @@calendar_guess.update_attributes(params[:calendar_guess])
        format.html { redirect_to @calendar_guess, notice: 'Calendar guess was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @calendar_guess.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calendar_guess/1
  # DELETE /calendar_guess/1.json
  def destroy
    @calendar_guess = CalendarGuess.find(params[:id])
    @calendar_guess.destroy

    respond_to do |format|
      format.html { redirect_to meeting_thread_jobs_url }
      format.json { head :no_content }
    end
  end
  
end
