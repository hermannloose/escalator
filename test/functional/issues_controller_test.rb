require 'test_helper'

class IssuesControllerTest < ActionController::TestCase
  setup do
    @issue = issues(:valid)
    @policy = escalation_policies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:issues)
  end

  test "should get only nested issues if requested" do
    get :index, :escalation_policy_id => @policy.to_param
    assert_response :success
    assert_not_nil assigns(:issues)
    assigns(:issues).each do |issue|
      assert issue.escalation_policy == @policy
    end
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create issue" do
    assert_difference ['Issue.count', 'Delayed::Job.count'] do
      post :create, :issue => @issue.attributes
    end

    assert_redirected_to issue_path(assigns(:issue))
  end

  test "should show issue" do
    get :show, :id => @issue.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @issue.to_param
    assert_response :success
  end

  test "should update issue" do
    put :update, :id => @issue.to_param, :issue => @issue.attributes
    assert_redirected_to issue_path(assigns(:issue))
  end

  test "should destroy issue" do
    assert_difference('Issue.count', -1) do
      delete :destroy, :id => @issue.to_param
    end

    assert_redirected_to issues_path
  end
end
