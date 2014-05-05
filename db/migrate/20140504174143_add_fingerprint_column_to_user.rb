class AddFingerprintColumnToUser < ActiveRecord::Migration
  def change
    add_column :lectures, :video_fingerprint, :string
    add_column :lectures, :slide_fingerprint, :string
  end
end
