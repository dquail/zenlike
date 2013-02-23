class AddUserIdAndMeetingThreadIdToCalendarGuesses < ActiveRecord::Migration
  def change
    add_column :calendar_guesses, :meeting_thread_id, :integer
    add_column :calendar_guesses, :user_id, :integer
  end
end
