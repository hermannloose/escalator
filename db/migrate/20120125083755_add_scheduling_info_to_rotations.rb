class AddSchedulingInfoToRotations < ActiveRecord::Migration
  def change
    change_table :rotations do |t|
      t.integer :rotate_every
      t.references :delayed_job
    end
  end
end
