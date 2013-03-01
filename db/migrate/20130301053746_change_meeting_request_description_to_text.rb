class ChangeMeetingRequestDescriptionToText < ActiveRecord::Migration
  def self.up
    change_table :meeting_requests do |t|
      t.change :description, :text, :limit => nil
    end
  end
 
  def self.down
    change_table :meeting_requests do |t|
      t.change :description, :text, :limit => 255
    end
  end

end
