require 'test_helper'

class RotationsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @rotation = rotations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rotations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rotation" do
    assert_difference('Rotation.count') do
      post :create, :rotation => @rotation.attributes
    end

    assert_redirected_to rotation_path(assigns(:rotation))
  end

  test "should show rotation" do
    get :show, :id => @rotation.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @rotation.to_param
    assert_response :success
  end

  test "should update rotation" do
    put :update, :id => @rotation.to_param, :rotation => @rotation.attributes
    assert_redirected_to rotation_path(assigns(:rotation))
  end

  test "should destroy rotation" do
    assert_difference('Rotation.count', -1) do
      delete :destroy, :id => @rotation.to_param
    end

    assert_redirected_to rotations_path
  end
end
