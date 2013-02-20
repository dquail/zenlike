class ChangeStringToTextForEmailFromSendgrid < ActiveRecord::Migration
  
  def self.up
    change_table :meeting_threads do |t|
      t.change :text, :text, :limit => nil
      t.change :html, :text, :limit => nil
      t.change :headers, :text, :limit => nil
    end
  end
 
  def self.down
    change_table :meeting_threads do |t|
      t.change :text, :text, :limit => 255
      t.change :html, :text, :limit => 255
      t.change :headers, :text, :limit => 255
    end
  end

end
