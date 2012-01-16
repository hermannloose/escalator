require 'test_helper'

class RotationsControllerTest < ActionController::TestCase
  setup do
    @rotation = rotations(:one)
  end

  test "access control" do
    with_user nil do
      should_not_be_allowed_to :index, :rotations
      should_not_be_allowed_to :show, @rotation
      should_not_be_allowed_to :new, :rotations
      should_not_be_allowed_to :create, @rotation
      should_not_be_allowed_to :edit, @rotation
      should_not_be_allowed_to :update, @rotation
      should_not_be_allowed_to :destroy, @rotation
    end

    with_user user do
      should_be_allowed_to :index, :rotations
      should_be_allowed_to :show, @rotation

      should_not_be_allowed_to :new, :rotations
      should_not_be_allowed_to :create, @rotation
      should_not_be_allowed_to :edit, @rotation
      should_not_be_allowed_to :update, @rotation
      should_not_be_allowed_to :destroy, @rotation
    end

    with_user admin do
      should_be_allowed_to :index, :rotations
      should_be_allowed_to :show, @rotation
      should_be_allowed_to :new, :rotations
      should_be_allowed_to :create, @rotation
      should_be_allowed_to :edit, @rotation
      should_be_allowed_to :update, @rotation
      should_be_allowed_to :destroy, @rotation
    end
  end

  test "should get new" do
    with_user admin do
      get :new
      assert_response :success
    end
  end

  test "should create rotation" do
    with_user admin do
      assert_difference('Rotation.count') do
        post :create, :rotation => @rotation.attributes
      end

      assert_redirected_to rotation_path(assigns(:rotation))
    end
  end

  test "should show rotation" do
    with_user user do
      get :show, :id => @rotation.to_param
      assert_response :success
    end
  end

  test "should get edit" do
    with_user admin do
      get :edit, :id => @rotation.to_param
      assert_response :success
    end
  end

  test "should update rotation" do
    with_user admin do
      put :update, :id => @rotation.to_param, :rotation => @rotation.attributes
      assert_redirected_to rotation_path(assigns(:rotation))
    end
  end

  test "should destroy rotation" do
    with_user admin do
      assert_difference('Rotation.count', -1) do
        delete :destroy, :id => @rotation.to_param
      end

      assert_redirected_to rotations_path
    end
  end
end
