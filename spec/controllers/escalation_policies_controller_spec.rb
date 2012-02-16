require 'spec_helper'

describe EscalationPoliciesController do
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
  let(:escalation_policy) {
    FactoryGirl.create(:escalation_policy)
  }

  context "when guest" do
    it "should deny all access" do
      with_user nil do
        should_not_be_allowed_to :index, :escalation_policies
        should_not_be_allowed_to :show, :escalation_policies
        should_not_be_allowed_to :new, :escalation_policies
        should_not_be_allowed_to :create, :escalation_policies
        should_not_be_allowed_to :edit, :escalation_policies
        should_not_be_allowed_to :update, :escalation_policies
        should_not_be_allowed_to :destroy, :escalation_policies
      end
    end
  end

  context "when user" do
    it "should allow read-only access" do
      with_user(user) do
        should_be_allowed_to :index, :escalation_policies
        should_be_allowed_to :show, :escalation_policies
        should_not_be_allowed_to :new, :escalation_policies
        should_not_be_allowed_to :create, :escalation_policies
        should_not_be_allowed_to :edit, :escalation_policies
        should_not_be_allowed_to :update, :escalation_policies
        should_not_be_allowed_to :destroy, :escalation_policies
      end
    end
  end

  context "when admin" do
    it "should allow all access" do
      with_user(admin) do
        should_be_allowed_to :index, :escalation_policies
        should_be_allowed_to :show, :escalation_policies
        should_be_allowed_to :new, :escalation_policies
        should_be_allowed_to :create, :escalation_policies
        should_be_allowed_to :edit, :escalation_policies
        should_be_allowed_to :update, :escalation_policies
        should_be_allowed_to :destroy, :escalation_policies
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
        get :show, :id => escalation_policy.id
      end
    end

    subject { assigns(:escalation_policy) }

    it { should_not be_nil }
    it { should eql(escalation_policy) }
    specify { response.should render_template("show") }
  end

  describe "#new" do
    before :each do
      with_user(admin) do
        get :new
      end
    end

    subject { assigns(:escalation_policy) }

    it { should_not be_nil }
    it { should be_new_record }
    specify { response.should render_template("new") }
  end

  describe "#create" do
    let(:escalation_policy) {
      FactoryGirl.build(:escalation_policy)
    }

    let(:perform) {
      with_user(admin) do
        post :create, :escalation_policy => escalation_policy.attributes
      end
    }

    context "when saving the escalation policy succeeds" do
      before :each do
        perform
      end

      subject { assigns(:escalation_policy) }
      it { should_not be_nil }
      it { should be_persisted }
      specify { response.should redirect_to subject }
    end

    context "when saving the escalation policy fails" do
      before :each do
        EscalationPolicy.any_instance.stubs(:save).returns(false)
        perform
      end

      subject { assigns(:escalation_policy) }
      it { should_not be_nil }
      it { should be_new_record }
      specify { response.should render_template("new") }
    end
  end

  describe "#edit" do
    before :each do
      with_user(admin) do
        get :edit, :id => escalation_policy.id
      end
    end

    subject { assigns(:escalation_policy) }

    it { should_not be_nil }
    it { should eql(escalation_policy) }
    specify { response.should render_template("edit") }
  end

  describe "#update" do
    let(:perform) {
      with_user(admin) do
        put :update, :id => escalation_policy.id, :escalation_policy => escalation_policy.attributes
      end
    }

    context "when updating the escalation policy succeeds" do
      before :each do
        perform
      end

      subject { assigns(:escalation_policy) }
      it { should_not be_nil }
      it { should be_persisted }
      specify { response.should redirect_to subject }
    end

    context "when updating the escalation policy fails" do
      before :each do
        EscalationPolicy.any_instance.stubs(:update_attributes).returns(false)
        perform
      end

      subject { assigns(:escalation_policy) }
      it { should_not be_nil }
      it { should be_persisted }
      specify { response.should render_template("edit") }
    end
  end

  describe "#destroy" do
    before :each do
      with_user(admin) do
        delete :destroy, :id => escalation_policy.id
      end
    end

    subject { assigns(:escalation_policy) }
    it { should_not be_nil }
    it { should_not be_persisted }
    specify { response.should redirect_to :escalation_policies }
  end
end
