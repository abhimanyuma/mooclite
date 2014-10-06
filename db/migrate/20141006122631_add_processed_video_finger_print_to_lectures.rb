class AddProcessedVideoFingerPrintToLectures < ActiveRecord::Migration
  def change
    change_table :lectures do |t|
      t.string :processed_video_fingerprint
      t.integer :process_status, :default => 0
    end
  end
end
