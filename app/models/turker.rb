class Turker < User
  has_many :calendar_guesses
  
  has_many :available_jobs, :class_name => "MeetingThread", 
     :finder_sql => proc {"SELECT DISTINCT meeting_threads.*  FROM meeting_threads LEFT JOIN calendar_guesses ON meeting_threads.id = calendar_guesses.meeting_thread_id WHERE calendar_guesses.turker_id IS NULL OR calendar_guesses.turker_id <> #{self.id}"}, :readonly => true

end