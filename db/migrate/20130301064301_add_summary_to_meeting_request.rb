class AddSummaryToMeetingRequest < ActiveRecord::Migration
  def change
    add_column :meeting_requests, :summary, :string
  end
end
