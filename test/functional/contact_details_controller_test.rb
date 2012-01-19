require 'test_helper'

class ContactDetailsControllerTest < ActionController::TestCase
  setup do
    @contact_detail = contact_details(:u1_email)
  end

  test "access control" do
    with_user nil do
      should_not_be_allowed_to :index, :contact_details
      should_not_be_allowed_to :show, @contact_detail
      should_not_be_allowed_to :new, :contact_details
      should_not_be_allowed_to :create, @contact_detail
      should_not_be_allowed_to :edit, @contact_detail
      should_not_be_allowed_to :update, @contact_detail
      should_not_be_allowed_to :destroy, @contact_detail
    end

    with_user user do
      should_be_allowed_to :index, :contact_details
      should_be_allowed_to :show, @contact_detail

      should_not_be_allowed_to :new, :contact_details
      should_not_be_allowed_to :create, @contact_detail
      should_not_be_allowed_to :edit, @contact_detail
      should_not_be_allowed_to :update, @contact_detail
      should_not_be_allowed_to :destroy, @contact_detail
    end

    with_user admin do
      should_be_allowed_to :index, :contact_details
      should_be_allowed_to :show, @contact_detail
      should_be_allowed_to :new, :contact_details
      should_be_allowed_to :create, @contact_detail
      should_be_allowed_to :edit, @contact_detail
      should_be_allowed_to :update, @contact_detail
      should_be_allowed_to :destroy, @contact_detail
    end
  end

  test "should get index" do
    with_user user do
      get :index
      assert_response :success
      assert_not_nil assigns(:contact_details)
    end
  end

  test "should get new" do
    with_user admin do
      get :new
      assert_response :success
    end
  end

  test "should create contact_detail" do
    with_user admin do
      assert_difference('ContactDetail.count') do
        post :create, :contact_detail => @contact_detail.attributes
      end

      assert_redirected_to contact_detail_path(assigns(:contact_detail))
    end
  end

  test "should show contact_detail" do
    with_user admin do
      get :show, :id => @contact_detail.to_param
      assert_response :success
    end
  end

  test "should get edit" do
    with_user admin do
      get :edit, :id => @contact_detail.to_param
      assert_response :success
    end
  end

  test "should update contact_detail" do
    with_user admin do
      put :update, :id => @contact_detail.to_param, :contact_detail => @contact_detail.attributes
      assert_redirected_to contact_detail_path(assigns(:contact_detail))
    end
  end

  test "should destroy contact_detail" do
    with_user admin do
      assert_difference('ContactDetail.count', -1) do
        delete :destroy, :id => @contact_detail.to_param
      end

      assert_redirected_to contact_details_path
    end
  end
end
