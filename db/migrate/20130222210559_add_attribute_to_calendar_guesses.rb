class AddAttributeToCalendarGuesses < ActiveRecord::Migration
  def change
    add_column :calendar_guesses, :location, :string
    add_column :calendar_guesses, :participants, :string
    add_column :calendar_guesses, :time, :string
    add_column :calendar_guesses, :description, :text
  end
end
