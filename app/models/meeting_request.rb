require 'ri_cal'

class MeetingRequest < ActiveRecord::Base
  attr_accessible :summary, :datetime, :description, :end_date_time, :location, :meeting_thread_id, :participants, :start_date_time, :time_zone
  belongs_to :meeting_thread
  

  def send_to_participants
    access_token = self.meeting_thread.user.google_access_token
    refresh_token = self.meeting_thread.user.google_refresh_token
    expires_at = self.meeting_thread.user.google_expires_at
      
    if (access_token)
      Rails.logger.info "Comparing current time: #{Time.now.to_i} with: #{expires_at}"
      if (Time.now.to_i >= expires_at)
        Rails.logger.info "Generating a new token"
        access_token = self.refresh_token
      end
    else
      Rails.logger.info "No user access token.  Using our own"
      meeting_user = GoogleUser.find_by_email('meetings@zenlike.me')
      if (Time.now.to_i >= meeting_user.google_expires_at)
        Rails.logger.info "Getting a new token for system user"
        access_token = meeting_user.refresh_token
      else
        access_token = meeting_user.google_access_token
      end      
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

  def refresh_token
    data = {
      :client_id => GOOGLE_CLIENT_ID,
      :client_secret => GOOGLE_CLIENT_SECRET,
      :refresh_token => self.meeting_thread.user.google_refresh_token,
      :grant_type => 'refresh_token'
    }
    
    @response = ActiveSupport::JSON.decode(RestClient.post "https://accounts.google.com/o/oauth2/token", data)
    Rails.logger.info "Received a new response for token refresh"
    if @response["access_token"].present?
      self.meeting_thread.user.google_access_token = @response["access_token"]
      self.meeting_thread.user.google_expires_at = @response["expires_at"]
      self.meeting_thread.user.save!
      Rails.logger.info "Returning new token #{@response["access_token"]}"
      return @response["access_token"]
    else
      Rails.logger.error "Couldn't generate new token for user"
      return nil
    end
    
  rescue RestClient::BadRequest => e
    Rails.logger.error "Bad request when refreshing google token"

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
