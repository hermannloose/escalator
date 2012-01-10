class AddEscalationPolicyToIssues < ActiveRecord::Migration
  def change
    change_table :issues do |t|
      t.references :escalation_policy
      t.index :escalation_policy_id
    end
  end
end
