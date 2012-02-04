class AddDetailsToContactDetails < ActiveRecord::Migration
  def change
    add_column :contact_details, :details, :text
  end
end
