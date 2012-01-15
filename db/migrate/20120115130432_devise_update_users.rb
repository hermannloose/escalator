class DeviseUpdateUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      # Not using t.database_authenticatable because :email already existed.
      t.string :encrypted_password, :limit => 128
      t.string :password_salt
      t.recoverable
      t.rememberable
      t.trackable

      t.index :reset_password_token, :unique => true
    end
  end
end
