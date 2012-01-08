require 'test_helper'

class ContactDetailTest < ActiveSupport::TestCase
  setup do
    @contact_detail = contact_details(:valid)
  end

  test "should save valid details" do
    assert @contact_detail.save
  end

  test "should validate presence of name" do
    @contact_detail.name = nil
    assert !@contact_detail.save
  end

  test "should validate presence of user" do
    @contact_detail.user = nil
    assert !@contact_detail.save
  end
end
