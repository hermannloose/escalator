class AddRotationToAlertingSteps < ActiveRecord::Migration
  def change
    change_table :alerting_steps do |t|
      t.references :rotation_membership
      t.index :rotation_membership_id
    end
  end
end
