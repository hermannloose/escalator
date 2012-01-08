class CreateEscalationSteps < ActiveRecord::Migration
  def change
    create_table :escalation_steps do |t|
      t.integer :delay
      t.references :rotation

      t.timestamps
    end
    add_index :escalation_steps, :rotation_id
  end
end
