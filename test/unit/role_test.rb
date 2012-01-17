require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  setup do
    @role = roles(:valid)
  end

  test "should save valid role" do
    assert @role.save
  end

  test "should validate presence of name" do
    @role.name = nil
    assert !@role.save
  end
end
