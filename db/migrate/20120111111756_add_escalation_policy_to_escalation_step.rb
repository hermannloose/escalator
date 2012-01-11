class AddEscalationPolicyToEscalationStep < ActiveRecord::Migration
  def change
    change_table :escalation_steps do |t|
      t.references :escalation_policy
      t.index :escalation_policy_id
    end
  end
end
