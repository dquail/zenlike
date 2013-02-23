class ChangeUserIdToTurkIdInCalendarGuess < ActiveRecord::Migration
  def up
    rename_column :calendar_guesses, :user_id, :turk_id
  end

  def down
    rename_column :calendar_guesses, :turk_id, :user_id    
  end
end
