require 'test_helper'

class EscalationPoliciesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:valid)
    sign_in @user

    @escalation_policy = escalation_policies(:valid)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:escalation_policies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create escalation_policy" do
    assert_difference('EscalationPolicy.count') do
      post :create, :escalation_policy => @escalation_policy.attributes
    end

    assert_redirected_to escalation_policy_path(assigns(:escalation_policy))
  end

  test "should show escalation_policy" do
    get :show, :id => @escalation_policy.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @escalation_policy.to_param
    assert_response :success
  end

  test "should update escalation_policy" do
    put :update, :id => @escalation_policy.to_param, :escalation_policy => @escalation_policy.attributes
    assert_redirected_to escalation_policy_path(assigns(:escalation_policy))
  end

  test "should destroy escalation_policy" do
    assert_difference('EscalationPolicy.count', -1) do
      delete :destroy, :id => @escalation_policy.to_param
    end

    assert_redirected_to escalation_policies_path
  end
end
