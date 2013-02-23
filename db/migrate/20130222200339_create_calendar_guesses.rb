class CreateCalendarGuesses < ActiveRecord::Migration
  def change
    create_table :calendar_guesses do |t|

      t.timestamps
    end
  end
end
