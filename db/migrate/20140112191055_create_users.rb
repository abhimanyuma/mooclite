class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :name,  null: false
      t.string  :email, null: false, unique: true
      t.string  :password_digest, null: false
      t.string  :institute
      t.string  :role
      t.string  :slug

      t.timestamps
    end

    add_index :users, :name
    add_index :users, :email
  end
end
