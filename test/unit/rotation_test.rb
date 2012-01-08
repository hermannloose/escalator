require 'test_helper'

class RotationTest < ActiveSupport::TestCase
  test "should validate presence of name" do
    rotation = Rotation.new
    assert !rotation.save
  end
end
