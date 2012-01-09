require 'test_helper'

class ContactDetailPropertyTest < ActiveSupport::TestCase
  setup do
    @contact_detail_property = contact_detail_properties(:valid)
  end

  test "should save valid contact detail property" do
    assert @contact_detail_property.save
  end

  test "should validate presence of contact detail" do
    @contact_detail_property.contact_detail = nil
    assert !@contact_detail_property.save
  end

  test "should validate presence of key" do
    @contact_detail_property.key = nil
    assert !@contact_detail_property.save
  end
end
