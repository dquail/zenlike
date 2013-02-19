class CreateMeetingThreads < ActiveRecord::Migration
  def change
    create_table :meeting_threads do |t|
      t.integer :user_id
      t.string :headers
      t.string :text
      t.string :html
      t.string :from
      t.string :to
      t.string :cc
      t.string :subject
      t.integer :attachmen_count

      t.timestamps
    end
  end
end
