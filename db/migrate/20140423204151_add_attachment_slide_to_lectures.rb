class AddAttachmentSlideToLectures < ActiveRecord::Migration
  def self.up
    change_table :lectures do |t|
      t.attachment :slide
    end
  end

  def self.down
    drop_attached_file :lectures, :slide
  end
end
