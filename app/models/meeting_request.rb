require 'ri_cal'

class MeetingRequest < ActiveRecord::Base
  attr_accessible :summary, :datetime, :description, :end_date_time, :location, :meeting_thread_id, :participants, :start_date_time, :time_zone
  belongs_to :meeting_thread
  

  def send_to_participants

    #TODO - Get either the users google access token, or our own access token
    Rails.logger.info "Sending meeting request to participants using google calendar"
    Rails.logger.info "User: #{self.meeting_thread.user.email}"
    access_token = self.meeting_thread.user.google_access_token
    refresh_token = self.meeting_thread.user.google_refresh_token
    
    Rails.logger.info "Using access token #{access_token}"
    
    if not access_token
      Rails.logger.info "No access token.  Using our own"
      return
    end
    
    #Create 
    client = Google::APIClient.new
    client.authorization.access_token = access_token
    service = client.discovered_api('calendar', 'v3')

    participant_hash_array = []
    email_array = self.participants.split(',')
    email_array.each do |email|
      participant_hash_array.push({email: email.strip})
    end
    
    Rails.logger.info "Participants: #{participant_hash_array}"
    
    event = {
      'summary' => self.summary,
      'description' => self.description,
      'location' => self.location,
      'start' => {
        'dateTime' => self.start_date_time.strftime("%FT%T%:z")
      },
      'end' => {
        'dateTime' => self.end_date_time.strftime("%FT%T%:z")
      },
        'attendees' => participant_hash_array
      }
    
    Rails.logger.info "JSON being used #{JSON.dump(event)}"

    result = client.execute(:api_method => service.events.insert,
                            :parameters => {'calendarId' => 'primary', 'sendNotifications' => true},
                            :body => JSON.dump(event),
                            :headers => {'Content-Type' => 'application/json'})    
    
    Rails.logger.info "Result of google call: #{result}"
    
    #TODO - make sure the result passed.  Otherwise send an error email to us and the user. or retry
    
    #email the user letting them know it's been added to their calendar.  The google calendar event is only sent to participants, not the owner of the calendar
    if (self.meeting_thread.user.google_access_token)
      MeetingRequestMailer.send_meeting_request(self).deliver
    end

  end

  def to_ics_test
    event = RiCal.Event do
          description "Test description"
          dtstart     DateTime.new(2001,2,3)
          dtend       DateTime.new(2001,2,4)
          location    "test location"
          add_attendee "david_quail@hotmail.com"

        end    
  end


  def to_ics
    meeting_request = self
    event = RiCal.Event do
          description meeting_request.description
          summary     meeting_request.summary
          dtstart     meeting_request.start_date_time.strftime("%Y%m%dT%H%M%S")
          dtend       meeting_request.start_date_time.strftime("%Y%m%dT%H%M%S")
          location    meeting_request.location
          organizer   'accounts@zenlike.me'
          uid         meeting_request.id.to_s
          meeting_request.participants.split(/,\s*/).each do |email| 
            add_attendee email
          end
        end  
  end    
end
