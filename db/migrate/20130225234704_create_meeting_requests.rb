class CreateMeetingRequests < ActiveRecord::Migration
  def change
    create_table :meeting_requests do |t|
      t.integer :meeting_thread_id
      t.string :location
      t.string :participants
      t.string :description
      t.string :start_date_time
      t.string :datetime
      t.datetime :end_date_time
      t.string :time_zone

      t.timestamps
    end
  end
end
