class ChangeUserIdToTurkerIdInCalendarGuess < ActiveRecord::Migration
  def up
    rename_column :calendar_guesses, :turk_id, :turker_id
  end

  def down
    rename_column :calendar_guesses, :turker_id, :turk_id
  end
end
