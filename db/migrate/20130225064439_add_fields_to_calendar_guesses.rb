class AddFieldsToCalendarGuesses < ActiveRecord::Migration
  def change
    add_column :calendar_guesses, :start_time, :datetime
    add_column :calendar_guesses, :end_time, :datetime
    add_column :calendar_guesses, :time_zone, :string
    remove_column :calendar_guesses, :time
  end
end
