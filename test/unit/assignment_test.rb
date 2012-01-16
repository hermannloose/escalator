require 'test_helper'

class AssignmentTest < ActiveSupport::TestCase
  setup do
    @assignment = assignments(:valid)
  end

  test "should save valid assignment" do
    assert @assignment.save
  end

  test "should validate presence of user" do
    @assignment.user = nil
    assert !@assignment.save
  end

  test "should validate presence of role" do
    @assignment.role = nil
    assert !@assignment.save
  end
end
