require 'test_helper'

class RotationTest < ActiveSupport::TestCase
  setup do
    @rotation = rotations(:valid)
  end

  test "should save valid rotation" do
    assert @rotation.save
  end

  test "should validate presence of name" do
    @rotation.name = nil
    assert !@rotation.save
  end
end
