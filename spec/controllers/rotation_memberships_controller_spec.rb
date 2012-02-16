require 'spec_helper'

describe RotationMembershipsController do
  render_views
  setup_mapping

  before :each do
    @user = Factory(:user)
    sign_in @user
  end

  context "when guest" do
    it "should deny all access" do
      with_user nil do
        should_not_be_allowed_to :index, :rotation_memberships
        should_not_be_allowed_to :show, :rotation_memberships
        should_not_be_allowed_to :new, :rotation_memberships
        should_not_be_allowed_to :create, :rotation_memberships
        should_not_be_allowed_to :edit, :rotation_memberships
        should_not_be_allowed_to :update, :rotation_memberships
        should_not_be_allowed_to :destroy, :rotation_memberships
      end
    end
  end

  context "when user" do
    it "should allow access to own memberships" do

      @rotation_membership = Factory(:rotation_membership, :user => @user)

      with_user @user do
        should_not_be_allowed_to :index, :rotation_memberships
        should_be_allowed_to :show, @rotation_membership
        should_not_be_allowed_to :new, :rotation_memberships
        should_not_be_allowed_to :create, :rotation_memberships
        should_not_be_allowed_to :edit, :rotation_memberships
        should_not_be_allowed_to :update, :rotation_memberships
        should_not_be_allowed_to :destroy, :rotation_memberships
      end
    end
  end

  context "when admin" do
    it "should allow access to own memberships" do
      @admin = Factory(:admin)
      sign_in @admin

      @rotation_membership = Factory(:rotation_membership, :user => @admin)

      with_user @admin do
        should_not_be_allowed_to :index, :rotation_memberships
        should_be_allowed_to :show, @rotation_membership
        should_not_be_allowed_to :new, :rotation_memberships
        should_not_be_allowed_to :create, :rotation_memberships
        should_not_be_allowed_to :edit, :rotation_memberships
        should_not_be_allowed_to :update, :rotation_memberships
        should_not_be_allowed_to :destroy, :rotation_memberships
      end
    end
  end
end
