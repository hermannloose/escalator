require 'spec_helper'

describe RotationsController do
  let(:admin) {
    admin = FactoryGirl.create(:admin)
    sign_in admin
    admin
  }

  let(:user) {
    user = FactoryGirl.create(:user)
    sign_in user
    user
  }

  let!(:rotation) {
    rotation = FactoryGirl.create(:rotation)
  }

  context "when guest" do
    it "should deny all access" do
      with_user nil do
        should_not_be_allowed_to :index, :rotations
        should_not_be_allowed_to :show, :rotations
        should_not_be_allowed_to :new, :rotations
        should_not_be_allowed_to :create, :rotations
        should_not_be_allowed_to :edit, :rotations
        should_not_be_allowed_to :update, :rotations
        should_not_be_allowed_to :destroy, :rotations
      end
    end
  end

  context "when user" do
    it "should allow read-only access" do
      with_user(user) do
        should_be_allowed_to :index, :rotations
        should_be_allowed_to :show, :rotations
        should_not_be_allowed_to :new, :rotations
        should_not_be_allowed_to :create, :rotations
        should_not_be_allowed_to :edit, :rotations
        should_not_be_allowed_to :update, :rotations
        should_not_be_allowed_to :destroy, :rotations
      end
    end
  end

  context "when admin" do
    it "should allow all access" do
      with_user(admin) do
        should_be_allowed_to :index, :rotations
        should_be_allowed_to :show, :rotations
        should_be_allowed_to :new, :rotations
        should_be_allowed_to :create, :rotations
        should_be_allowed_to :edit, :rotations
        should_be_allowed_to :update, :rotations
        should_be_allowed_to :destroy, :rotations
      end
    end
  end

  describe "#index" do
    before :each do
      with_user(user) do
        get :index
      end
    end

    specify { response.should render_template("index") }
  end

  describe "#show" do
    before :each do
      with_user(user) do
        get :show, :id => rotation.id
      end
    end

    specify { response.should render_template("show") }
  end

  describe "#new" do
    before :each do
      with_user(admin) do
        get :new
      end
    end

    specify { response.should render_template("new") }
  end

  describe "#create" do
    let(:perform) {
      with_user(admin) do
        post :create, :rotation => rotation.attributes
      end
    }

    context "when saving the rotation succeeds" do
      before :each do
        perform
      end

      specify { response.should redirect_to assigns(:rotation) }
    end

    context "when saving the rotation fails" do
      before :each do
        Rotation.any_instance.stubs(:valid?).returns(false)
        perform
      end

      specify { response.should render_template("new") }
    end
  end

  describe "#edit" do
    before :each do
      with_user(admin) do
        get :edit, :id => rotation.id
      end
    end

    specify { response.should render_template("edit") }
  end

  describe "#update" do
    let(:perform) {
      with_user(admin) do
        put :update, :id => rotation.id, :rotation => rotation.attributes
      end
    }

    context "when saving the rotation succeeds" do
      before :each do
        perform
      end

      specify { response.should redirect_to rotation }
    end

    context "when saving the rotation fails" do
      before :each do
        Rotation.any_instance.stubs(:valid?).returns(false)
        perform
      end

      specify { response.should render_template("edit") }
    end
  end

  describe "#destroy" do
    before :each do
      with_user(admin) do
        delete :destroy, :id => rotation.id
      end
    end

    specify { response.should redirect_to :rotations }
  end
end
