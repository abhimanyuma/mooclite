class AddAttachmentVideoToLectures < ActiveRecord::Migration
  def self.up
    change_table :lectures do |t|
      t.attachment :video
    end
  end

  def self.down
    drop_attached_file :lectures, :video
  end
end
