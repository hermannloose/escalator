class AddAssigneeToIssues < ActiveRecord::Migration
  def change
    change_table :issues do |t|
      t.references :assignee
      t.index :assignee_id
    end
  end
end
