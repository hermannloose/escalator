require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "access control" do
    with_user nil do
      should_not_be_allowed_to :index, :users
      should_not_be_allowed_to :show, @user
      should_not_be_allowed_to :new, :users
      should_not_be_allowed_to :create, @user
      should_not_be_allowed_to :edit, @user
      should_not_be_allowed_to :update, @user
      should_not_be_allowed_to :destroy, @user
    end

    with_user user do
      should_be_allowed_to :index, :users
      should_be_allowed_to :show, @user

      should_not_be_allowed_to :new, :users
      should_not_be_allowed_to :create, @user
      should_not_be_allowed_to :edit, @user
      should_not_be_allowed_to :update, @user
      should_not_be_allowed_to :destroy, @user
    end

    with_user admin do
      should_be_allowed_to :index, :users
      should_be_allowed_to :show, @user
      should_be_allowed_to :new, :users
      should_be_allowed_to :create, @user
      should_be_allowed_to :edit, @user
      should_be_allowed_to :update, @user
      should_be_allowed_to :destroy, @user
    end
  end

  test "should get index" do
    with_user user do
      get :index
      assert_response :success
      assert_not_nil assigns(:users)
    end
  end

  test "should get new" do
    with_user admin do
      get :new
      assert_response :success
    end
  end

  test "should create user" do
    user_fields = {
      :name => "new user",
      :email => "unused@example.com",
      :password => "present",
      :password_confirmation => "present"
    }

    with_user admin do
      assert_difference('User.count') do
        post :create, :user => user_fields
      end

      assert_redirected_to user_path(assigns(:user))
    end
  end

  test "should show user" do
    with_user user do
      get :show, :id => @user.to_param
      assert_response :success
    end
  end

  test "should get edit" do
    with_user admin do
      get :edit, :id => @user.to_param
      assert_response :success
    end
  end

  test "should update user" do
    with_user admin do
      put :update, :id => @user.to_param, :user => @user.attributes
      assert_redirected_to user_path(assigns(:user))
    end
  end

  test "should destroy user" do
    with_user admin do
      assert_difference('User.count', -1) do
        delete :destroy, :id => @user.to_param
      end

      assert_redirected_to users_path
    end
  end
end
