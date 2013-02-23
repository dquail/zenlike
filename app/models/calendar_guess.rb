class CalendarGuess < ActiveRecord::Base
  attr_accessible :participants, :time, :location, :description, :turker_id, :meeting_thread_id
  validates_presence_of :participants, :time, :location, :turker_id, :meeting_thread_id
  
  belongs_to :turker, :class_name => "Turker", :foreign_key => 'turker_id'
  belongs_to :meeting_thread
end
