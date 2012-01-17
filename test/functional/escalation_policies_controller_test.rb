require 'test_helper'

class EscalationPoliciesControllerTest < ActionController::TestCase
  setup do
    @escalation_policy = escalation_policies(:valid)
  end

  test "access control" do
    with_user nil do
      should_not_be_allowed_to :index, :escalation_policies
      should_not_be_allowed_to :show, @escalation_policy
      should_not_be_allowed_to :new, :escalation_policies
      should_not_be_allowed_to :create, @escalation_policy
      should_not_be_allowed_to :edit, @escalation_policy
      should_not_be_allowed_to :update, @escalation_policy
      should_not_be_allowed_to :destroy, @escalation_policy
    end

    with_user user do
      should_be_allowed_to :index, :escalation_policies
      should_be_allowed_to :show, @escalation_policy

      should_not_be_allowed_to :new, :escalation_policies
      should_not_be_allowed_to :create, @escalation_policy
      should_not_be_allowed_to :edit, @escalation_policy
      should_not_be_allowed_to :update, @escalation_policy
      should_not_be_allowed_to :destroy, @escalation_policy
    end

    with_user admin do
      should_be_allowed_to :index, :escalation_policies
      should_be_allowed_to :show, @escalation_policy
      should_be_allowed_to :new, :escalation_policies
      should_be_allowed_to :create, @escalation_policy
      should_be_allowed_to :edit, @escalation_policy
      should_be_allowed_to :update, @escalation_policy
      should_be_allowed_to :destroy, @escalation_policy
    end
  end

  test "should get index" do
    with_user user do
      get :index
      assert_response :success
      assert_not_nil assigns(:escalation_policies)
    end
  end

  test "should get new" do
    with_user admin do
      get :new
      assert_response :success
    end
  end

  test "should create escalation_policy" do
    with_user admin do
      assert_difference('EscalationPolicy.count') do
        post :create, :escalation_policy => @escalation_policy.attributes
      end

      assert_redirected_to escalation_policy_path(assigns(:escalation_policy))
    end
  end

  test "should show escalation_policy" do
    with_user user do
      get :show, :id => @escalation_policy.to_param
      assert_response :success
    end
  end

  test "should get edit" do
    with_user admin do
      get :edit, :id => @escalation_policy.to_param
      assert_response :success
    end
  end

  test "should update escalation_policy" do
    with_user admin do
      put :update, :id => @escalation_policy.to_param, :escalation_policy => @escalation_policy.attributes
      assert_redirected_to escalation_policy_path(assigns(:escalation_policy))
    end
  end

  test "should destroy escalation_policy" do
    with_user admin do
      assert_difference('EscalationPolicy.count', -1) do
        delete :destroy, :id => @escalation_policy.to_param
      end

      assert_redirected_to escalation_policies_path
    end
  end
end
