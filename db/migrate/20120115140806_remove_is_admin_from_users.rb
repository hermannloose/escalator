class RemoveIsAdminFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :is_admin
  end

  def down
    add_column :users, :is_admin, :boolean
  end
end
