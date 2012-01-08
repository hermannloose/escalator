class CreateContactDetails < ActiveRecord::Migration
  def change
    create_table :contact_details do |t|
      t.string :name
      t.string :category
      t.string :value
      t.references :user

      t.timestamps
    end
    add_index :contact_details, :user_id
  end
end
