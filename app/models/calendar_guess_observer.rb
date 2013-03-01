PERCENTAGE_OF_MATCHING_GUESSES_REQUIRED = 0
NUMBER_OF_GUESSES_BEFORE_GIVING_UP = 5

class CalendarGuessObserver < ActiveRecord::Observer
  def after_create(calendar_guess)
    #Test to see if we've reached the threashold of correct turker votes
    #if so, send out the real ics file

    Rails.logger.debug "CalendarGuessObserver "

    #todo
    #  1.  Get the other calendar_guesses for the meeting_thread
    #  2.  If the calendar_guesses are mostly all the same create a meeting_request associated to the meeting_thread
    #  3.  Save the meeting_request
    #  4.  NOTE - This observer isn't responsible for sending out the invite.  Thats what the meeting_request listener will do
    
    
    meeting_thread = calendar_guess.meeting_thread
    previous_guesses = meeting_thread.calendar_guesses    
    matching_guesses = []
    
    while (previous_guesses.length > 0)
      previous_guess = previous_guesses.pop      
      if (previous_guess == calendar_guess)
        matching_guesses<<previous_guess
      end
    end
    
    if (matching_guesses.length.to_f / meeting_thread.calendar_guesses.length.to_f > PERCENTAGE_OF_MATCHING_GUESSES_REQUIRED)
      #We have a match
      # :participants, :start_date_time, :end_date_time, :time_zone, :location, :description, :turker_id, :meeting_thread_id
      meeting_thread.status = 'processed'
      meeting_thread.save
      meeting_request = meeting_thread.build_meeting_request
      meeting_request.start_date_time = calendar_guess.start_date_time
      meeting_request.end_date_time = calendar_guess.end_date_time
      meeting_request.time_zone = calendar_guess.time_zone
      meeting_request.location = calendar_guess.location
      meeting_request.participants = calendar_guess.participants
      meeting_request.description = calendar_guess.description
      meeting_request.summary = calendar_guess.summary
      meeting_request.save
    end
    if (meeting_thread.calendar_guesses.length + 1 >= NUMBER_OF_GUESSES_BEFORE_GIVING_UP)
      #We've failed and can't create a match
      meeting_thread.status = 'failed'
      meeting_thread.save
    end

  end
  
  #Todo Add an observer when email field changes
  
  
end