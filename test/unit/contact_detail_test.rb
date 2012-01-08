require 'test_helper'

class ContactDetailTest < ActiveSupport::TestCase
  test "should validate presence of name" do
    detail = ContactDetail.new
    assert !detail.save
  end
end
