# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

# Roles
Role.delete_all
admin_role = Role.create({ :name => "admin" })
user_role = Role.create({ :name => "user" })

# Default admin account
User.delete_all
User.create([
  {
    :name => "Mechthild von Rootrecht",
    :email => "mail@example.com",
    :roles => [ admin_role, user_role ],
    :password => "password"
  }
])
