class RenameDelayColumns < ActiveRecord::Migration
  def change
    change_table :alerting_steps do |t|
      t.rename :delay, :delay_minutes
    end

    change_table :escalation_steps do |t|
      t.rename :delay, :delay_minutes
    end
  end
end
