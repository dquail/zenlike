class CalendarGuess < ActiveRecord::Base
  
  attr_accessible :summary, :participants, :start_date_time, :end_date_time, :time_zone, :location, :description, :turker_id, :meeting_thread_id
  validates_presence_of :participants, :start_date_time, :end_date_time, :time_zone, :location, :turker_id, :meeting_thread_id
  validate :check_participants
  validate :start_must_be_before_end_time
  
  belongs_to :turker, :class_name => "Turker", :foreign_key => 'turker_id'
  belongs_to :meeting_thread
  
  def check_participants
    participants.split(/,\s*/).each do |email| 
      unless email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
        errors.add(:participants, "are invalid due to #{email}.  Must be comma separated list of email addresses")
      end
    end
  end  
  
  def start_must_be_before_end_time
      errors.add(:start_time, "must be before end time") unless
         self.start_date_time < self.end_date_time
  end  
    
  def == (other)
    self_participant_array = self.participants.split(',')
    other_participant_array = other.participants.split(',')
    
    if (self_participant_array - other_participant_array).length >  0 || (other_participant_array - self_participant_array).length > 0
      return false 
    end

    if (self.start_date_time != other.start_date_time) then return false end
    if (self.end_date_time != other.end_date_time)then return false end
    if (self.time_zone != other.time_zone)then return false end
    if (self.location != other.location)then return false end
    if (self.description != other.description)then return false end
    if (self.meeting_thread_id != other.meeting_thread_id)then return false end
    return true
    
  end  
end
