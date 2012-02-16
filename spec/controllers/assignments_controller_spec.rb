require 'spec_helper'

describe AssignmentsController do
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
  let(:assignment) {
    FactoryGirl.create(:assignment)
  }

  context "when guest" do
    it "should deny all access" do
      with_user nil do
        should_not_be_allowed_to :index, :assignments
        should_not_be_allowed_to :show, :assignments
        should_not_be_allowed_to :new, :assignments
        should_not_be_allowed_to :create, :assignments
        should_not_be_allowed_to :edit, :assignments
        should_not_be_allowed_to :update, :assignments
        should_not_be_allowed_to :destroy, :assignments
      end
    end
  end

  context "when user" do
    it "should deny all access" do
      with_user(user) do
        should_not_be_allowed_to :index, :assignments
        should_not_be_allowed_to :show, :assignments
        should_not_be_allowed_to :new, :assignments
        should_not_be_allowed_to :create, :assignments
        should_not_be_allowed_to :edit, :assignments
        should_not_be_allowed_to :update, :assignments
        should_not_be_allowed_to :destroy, :assignments
      end
    end
  end

  context "when admin" do
    it "should allow all access" do
      with_user(admin) do
        should_be_allowed_to :index, :assignments
        should_be_allowed_to :show, :assignments
        should_be_allowed_to :new, :assignments
        should_be_allowed_to :create, :assignments
        should_be_allowed_to :edit, :assignments
        should_be_allowed_to :update, :assignments
        should_be_allowed_to :destroy, :assignments
      end
    end
  end

  describe "#index" do
    before :each do
      with_user(admin) do
        get :index
      end
    end

    specify { response.should render_template("index") }
  end

  describe "#show" do
    before :each do
      with_user(admin) do
        get :show, :id => assignment.id
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
    let(:assignment) {
      FactoryGirl.build(:assignment)
    }

    let(:perform) {
      with_user(admin) do
        post :create, :assignment => assignment.attributes
      end
    }

    context "when saving the assignment succeeds" do
      before :each do
        perform
      end

      subject { assigns(:assignment) }

      it { should_not be_nil }
      it { should be_persisted }
      specify { response.should redirect_to subject }
    end

    context "when saving the assignment fails" do
      before :each do
        Assignment.any_instance.stubs(:save).returns(false)
        perform
      end

      subject { assigns(:assignment) }

      it { should_not be_nil }
      it { should be_new_record }
      specify { response.should render_template("new") }
    end
  end

  describe "#edit" do
    before :each do
      with_user(admin) do
        get :edit, :id => assignment.id
      end
    end

    specify { response.should render_template("edit") }
  end

  describe "#update" do
    let(:perform) {
      with_user(admin) do
        put :update, :id => assignment.id, :assignment => assignment.attributes
      end
    }

    context "when updating the assignment succeeds" do
      before :each do
        perform
      end

      subject { assigns(:assignment) }

      it { should_not be_nil }
      it { should be_persisted }
      specify { response.should redirect_to subject }
    end

    context "when updating the assignment fails" do
      before :each do
        Assignment.any_instance.stubs(:update_attributes).returns(false)
        perform
      end

      subject { assigns(:assignment) }

      it { should_not be_nil }
      it { should be_persisted }
      specify { response.should render_template("edit") }
    end
  end

  describe "#destroy" do
    before :each do
      with_user(admin) do
        delete :destroy, :id => assignment.id
      end
    end

    subject { assigns(:assignment) }

    it { should_not be_nil }
    it { should_not be_persisted }
    specify { response.should redirect_to :assignments }
  end
end
