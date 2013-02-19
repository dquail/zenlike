class MeetingThread < ActiveRecord::Base
  attr_accessible :attachmen_count, :cc, :from, :headers, :html, :subject, :text, :to
  
  validates_presence_of :from, :to
  
  belongs_to :user
  
end
