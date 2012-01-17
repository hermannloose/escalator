require 'test_helper'

class IssuesControllerTest < ActionController::TestCase
  setup do
    @issue = issues(:valid)
    @policy = escalation_policies(:one)
  end

  test "access control" do
    with_user nil do
      should_not_be_allowed_to :index, :issues
      should_not_be_allowed_to :show, @issue
      should_not_be_allowed_to :new, :issues
      should_not_be_allowed_to :create, @issue
      should_not_be_allowed_to :edit, @issue
      should_not_be_allowed_to :update, @issue
      should_not_be_allowed_to :destroy, @issue
    end

    with_user user do
      should_be_allowed_to :index, :issues
      should_be_allowed_to :show, @issue
      should_be_allowed_to :new, :issues
      should_be_allowed_to :create, @issue

      should_not_be_allowed_to :edit, @issue
      should_not_be_allowed_to :update, @issue
      should_not_be_allowed_to :destroy, @issue
    end

    with_user admin do
      should_be_allowed_to :index, :issues
      should_be_allowed_to :show, @issue
      should_be_allowed_to :new, :issues
      should_be_allowed_to :create, @issue
      should_be_allowed_to :edit, @issue
      should_be_allowed_to :update, @issue
      should_be_allowed_to :destroy, @issue
    end
  end

  test "should get index" do
    with_user user do
      get :index
      assert_response :success
      assert_not_nil assigns(:issues)
    end
  end

  test "should get only nested issues if requested" do
    with_user user do
      get :index, :escalation_policy_id => @policy.to_param
      assert_response :success
      assert_not_nil assigns(:issues)
      assigns(:issues).each do |issue|
        assert issue.escalation_policy == @policy
      end
    end
  end

  test "should get new" do
    with_user admin do
      get :new
      assert_response :success
    end
  end

  test "should create issue" do
    with_user admin do
      assert_difference ['Issue.count', 'Delayed::Job.count'] do
        post :create, :issue => @issue.attributes
      end

      assert_redirected_to issue_path(assigns(:issue))
    end
  end

  test "should show issue" do
    with_user user do
      get :show, :id => @issue.to_param
      assert_response :success
    end
  end

  test "should get edit" do
    with_user admin do
      get :edit, :id => @issue.to_param
      assert_response :success
    end
  end

  test "should update issue" do
    with_user admin do
      put :update, :id => @issue.to_param, :issue => @issue.attributes
      assert_redirected_to issue_path(assigns(:issue))
    end
  end

  test "should destroy issue" do
    with_user admin do
      assert_difference('Issue.count', -1) do
        delete :destroy, :id => @issue.to_param
      end

      assert_redirected_to issues_path
    end
  end
end
