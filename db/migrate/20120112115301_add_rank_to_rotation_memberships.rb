class AddRankToRotationMemberships < ActiveRecord::Migration
  def change
    add_column :rotation_memberships, :rank, :integer
  end
end
