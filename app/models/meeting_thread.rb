class MeetingThread < ActiveRecord::Base
  #TODO - Don't mass assign user. Disable the new route for meeting_threads.  Only enalbe from sendgrid
  attr_accessible :user_id, :attachmen_count, :cc, :from, :headers, :html, :subject, :text, :to, :status
  
  validates_presence_of :from, :to
  
  belongs_to :user
  has_many :calendar_guesses
  has_one :meeting_request
  
  #validates_inclusion_of :status, :in => %w( 'open' 'processed' 'failed' ), :message => "The status is invalid"  
end
