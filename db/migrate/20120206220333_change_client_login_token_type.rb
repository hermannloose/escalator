class ChangeClientLoginTokenType < ActiveRecord::Migration
  def up
    change_table :google_client_login_credentials do |t|
      t.remove :token
      t.text :token
    end
  end

  def down
    change_table :google_client_login_credentials do |t|
      t.remove :token
      t.string :token
    end
  end
end
