# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

# Roles
Role.delete_all
admin_role, user_role = Role.create([
  {
    :name => "admin"
  },
  {
    :name => "user"
  }
])

# Users
User.delete_all
u1, u2 = User.create([
  {
    :name => "Admin User",
    :email => "admin@example.com",
    :roles => [ admin_role, user_role ],
    :password => "password"
  },
  {
    :name => "Normal User",
    :email => "user@example.com",
    :roles => [ user_role ],
    :password => "password"
  }
])

EscalationPolicy.delete_all
e1, e2 = EscalationPolicy.create([
  {
    :name => "Demo Policy"
  },
  {
    :name => "Demo Policy 2"
  }
])

Rotation.delete_all
r1, r2 = Rotation.create([
  {
    :name => "Demo Rotation Primary",
    :rotate_every => 1000
  },
  {
    :name => "Demo Rotation Secondary",
    :rotate_every => 1000
  }
])

RotationMembership.delete_all
rm1, rm2 = RotationMembership.create([
  {
    :rotation => r1,
    :user => u1,
    :rank => 0
  },
  {
    :rotation => r2,
    :user => u2,
    :rank => 0
  }
])

AlertingStep.delete_all

EscalationStep.delete_all
EscalationStep.create([
  {
    :escalation_policy => e1,
    :rotation => r1,
    :delay_minutes => 0
  },
  {
    :escalation_policy => e1,
    :rotation => r2,
    :delay_minutes => 3
  }
])
