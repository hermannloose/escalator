class CreateGoogleClientLoginCredentials < ActiveRecord::Migration
  def change
    create_table :google_client_login_credentials do |t|
      t.string :email
      t.string :token

      t.timestamps
    end
  end
end
