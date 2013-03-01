class AddSummaryToCalendarGuess < ActiveRecord::Migration
  def change
    add_column :calendar_guesses, :summary, :string    
  end
end
