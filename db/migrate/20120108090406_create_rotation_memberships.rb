class CreateRotationMemberships < ActiveRecord::Migration
  def change
    create_table :rotation_memberships do |t|
      t.references :rotation
      t.references :user

      t.timestamps
    end
    add_index :rotation_memberships, :rotation_id
    add_index :rotation_memberships, :user_id
  end
end
