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

  test "should destroy dependent contact_detail_properties" do
    contact_detail_properties = @contact_detail.contact_detail_properties
    @contact_detail.destroy
    assert @contact_detail.destroyed?
    contact_detail_properties.each do |property|
      property.reload
      assert property.destroyed?
    end
  end
end
