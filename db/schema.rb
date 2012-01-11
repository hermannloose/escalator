# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120111211847) do

  create_table "alerting_steps", :force => true do |t|
    t.integer  "delay_minutes"
    t.integer  "contact_detail_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rotation_membership_id"
  end

  add_index "alerting_steps", ["contact_detail_id"], :name => "index_alerting_steps_on_contact_detail_id"
  add_index "alerting_steps", ["rotation_membership_id"], :name => "index_alerting_steps_on_rotation_membership_id"

  create_table "contact_detail_properties", :force => true do |t|
    t.integer  "contact_detail_id"
    t.string   "key"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contact_detail_properties", ["contact_detail_id"], :name => "index_contact_detail_properties_on_contact_detail_id"

  create_table "contact_details", :force => true do |t|
    t.string   "name"
    t.string   "category"
    t.string   "value"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contact_details", ["user_id"], :name => "index_contact_details_on_user_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "escalation_policies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "escalation_steps", :force => true do |t|
    t.integer  "delay_minutes"
    t.integer  "rotation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "escalation_policy_id"
  end

  add_index "escalation_steps", ["escalation_policy_id"], :name => "index_escalation_steps_on_escalation_policy_id"
  add_index "escalation_steps", ["rotation_id"], :name => "index_escalation_steps_on_rotation_id"

  create_table "issues", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "posted_at"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "escalation_policy_id"
  end

  add_index "issues", ["escalation_policy_id"], :name => "index_issues_on_escalation_policy_id"

  create_table "rotation_memberships", :force => true do |t|
    t.integer  "rotation_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rotation_memberships", ["rotation_id"], :name => "index_rotation_memberships_on_rotation_id"
  add_index "rotation_memberships", ["user_id"], :name => "index_rotation_memberships_on_user_id"

  create_table "rotations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "is_admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
