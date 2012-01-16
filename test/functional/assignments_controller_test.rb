require 'test_helper'

class AssignmentsControllerTest < ActionController::TestCase
  setup do
    without_access_control do
      @assignment = assignments(:one)
    end
  end

  test "access control" do
    [nil, user].each do |user|
      with_user user do
        should_not_be_allowed_to :index, :assignments
        should_not_be_allowed_to :show, @assignment
        should_not_be_allowed_to :new, :assignments
        should_not_be_allowed_to :create, @assignment
        should_not_be_allowed_to :edit, @assignment
        should_not_be_allowed_to :update, @assignment
        should_not_be_allowed_to :destroy, @assignment
      end
    end

    with_user admin do
      should_be_allowed_to :index, :assignments
      should_be_allowed_to :show, @assignment
      should_be_allowed_to :new, :assignments
      should_be_allowed_to :create, @assignment
      should_be_allowed_to :edit, @assignment
      should_be_allowed_to :update, @assignment
      should_be_allowed_to :destroy, @assignment
    end
  end

  test "should get index" do
    with_user admin do
      get :index
      assert_response :success
      assert_not_nil assigns(:assignments)
    end
  end

  test "should get new" do
    with_user admin do
      get :new
      assert_response :success
    end
  end

  test "should create assignment" do
    with_user admin do
      assert_difference('Assignment.count') do
        post :create, :assignment => @assignment.attributes
      end

      assert_redirected_to assignment_path(assigns(:assignment))
    end
  end

  test "should show assignment" do
    with_user admin do
      get :show, :id => @assignment.to_param
      assert_response :success
    end
  end

  test "should get edit" do
    with_user admin do
      get :edit, :id => @assignment.to_param
      assert_response :success
    end
  end

  test "should update assignment" do
    with_user admin do
      put :update, :id => @assignment.to_param, :assignment => @assignment.attributes
      assert_redirected_to assignment_path(assigns(:assignment))
    end
  end

  test "should destroy assignment" do
    with_user admin do
      assert_difference('Assignment.count', -1) do
        delete :destroy, :id => @assignment.to_param
      end

      assert_redirected_to assignments_path
    end
  end
end
