class CreateAlertingSteps < ActiveRecord::Migration
  def change
    create_table :alerting_steps do |t|
      t.integer :delay
      t.references :contact_detail

      t.timestamps
    end
    add_index :alerting_steps, :contact_detail_id
  end
end
