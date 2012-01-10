class CreateContactDetailProperties < ActiveRecord::Migration
  def change
    create_table :contact_detail_properties do |t|
      t.references :contact_detail
      t.string :key
      t.string :value

      t.timestamps
    end
    add_index :contact_detail_properties, :contact_detail_id
  end
end
