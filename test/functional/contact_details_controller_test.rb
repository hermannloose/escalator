require 'test_helper'

class ContactDetailsControllerTest < ActionController::TestCase
  setup do
    @contact_detail = contact_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contact_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contact_detail" do
    assert_difference('ContactDetail.count') do
      post :create, :contact_detail => @contact_detail.attributes
    end

    assert_redirected_to contact_detail_path(assigns(:contact_detail))
  end

  test "should show contact_detail" do
    get :show, :id => @contact_detail.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @contact_detail.to_param
    assert_response :success
  end

  test "should update contact_detail" do
    put :update, :id => @contact_detail.to_param, :contact_detail => @contact_detail.attributes
    assert_redirected_to contact_detail_path(assigns(:contact_detail))
  end

  test "should destroy contact_detail" do
    assert_difference('ContactDetail.count', -1) do
      delete :destroy, :id => @contact_detail.to_param
    end

    assert_redirected_to contact_details_path
  end
end
