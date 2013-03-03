class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
           
  attr_accessible :email, :password, :password_confirmation, :default_time_zone, :remember_me, :roles
  
  #has_and_belongs_to_many :roles
  
  has_many :meeting_threads
  has_many :available_jobs, :class_name => "MeetingThread", 
       :finder_sql => proc {"SELECT DISTINCT meeting_threads.*  FROM meeting_threads LEFT JOIN calendar_guesses ON meeting_threads.id = calendar_guesses.meeting_thread_id WHERE calendar_guesses.turker_id IS NULL OR calendar_guesses.turker_id <> #{self.id}"}, :readonly => true  
  
  
  ROLES = %w[admin turker meeting_user assistant_user]
  
  def is?(role)
    roles.include?(role.to_s)
  end
    
  def roles=(roles)
   self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  def roles
   ROLES.reject do |r|
     ((roles_mask || 0) & 2**ROLES.index(r)).zero?
   end
  end
  
end