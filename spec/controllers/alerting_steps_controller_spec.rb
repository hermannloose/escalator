require 'spec_helper'

describe AlertingStepsController do
  render_views
  setup_mapping

  before :each do
    @user = FactoryGirl.create(:user)
    sign_in @user

    @rotation_membership = FactoryGirl.create(:rotation_membership, :user => @user)
    @alerting_step = FactoryGirl.create(:alerting_step,
        :contact_detail => FactoryGirl.create(:contact_detail, :user => @user),
        :rotation_membership => @rotation_membership)
  end

  context "when guest" do
    it "should deny all access" do
      with_user nil do
        should_not_be_allowed_to :index, :alerting_steps
        should_not_be_allowed_to :show, :alerting_steps
        should_not_be_allowed_to :new, :alerting_steps
        should_not_be_allowed_to :create, :alerting_steps
        should_not_be_allowed_to :edit, :alerting_steps
        should_not_be_allowed_to :update, :alerting_steps
        should_not_be_allowed_to :destroy, :alerting_steps
      end
    end
  end

  context "when user" do
    it "should allow access to own alerting steps" do
      with_user @user do
        should_not_be_allowed_to :index, :alerting_steps
        should_be_allowed_to :show, @alerting_step
        should_be_allowed_to :new, @alerting_step
        should_be_allowed_to :create, @alerting_step
        should_be_allowed_to :edit, @alerting_step
        should_be_allowed_to :update, @alerting_step
        should_be_allowed_to :destroy, @alerting_step
      end
    end
  end

  context "when admin" do
    it "should allow access to own alerting steps" do
      @admin = FactoryGirl.create(:admin)
      sign_in @admin

      @alerting_step = FactoryGirl.create(:alerting_step,
          :contact_detail => FactoryGirl.create(:contact_detail, :user => @admin),
          :rotation_membership => @rotation_membership)

      with_user @admin do
        should_not_be_allowed_to :index, :alerting_steps
        should_be_allowed_to :show, @alerting_step
        should_be_allowed_to :new, @alerting_step
        should_be_allowed_to :create, @alerting_step
        should_be_allowed_to :edit, @alerting_step
        should_be_allowed_to :update, @alerting_step
        should_be_allowed_to :destroy, @alerting_step
      end
    end
  end

  describe "#index" do
    before :each do
      with_user @user do
        get :index, :rotation_membership_id => @rotation_membership.id
      end
    end

    specify { response.should render_template("index") }
  end

  describe "#show" do
    before :each do
      with_user @user do
        get :show, :id => @alerting_step.id, :rotation_membership_id => @rotation_membership.id
      end
    end

    subject { assigns(:alerting_step) }
    it { should_not be_nil }
    it { should eql(@alerting_step) }
    its(:rotation_membership) { should eql(@rotation_membership) }

    specify { response.should render_template("show") }
  end

  describe "#new" do
    before :each do
      with_user @user do
        get :new, :rotation_membership_id => @rotation_membership.id
      end
    end

    subject { assigns(:alerting_step) }
    it { should_not be_nil }
    it { should be_new_record }
    its(:rotation_membership) { should eql(@rotation_membership) }

    specify { response.should render_template("new") }
  end

  describe "#create" do
    let(:perform) {
      with_user @user do
        post :create, :alerting_step => FactoryGirl.build(:alerting_step,
            :contact_detail => FactoryGirl.create(:contact_detail, :user => @user),
            :rotation_membership => @rotation_membership).attributes,
            :rotation_membership_id => @rotation_membership.id
      end
    }

    context "when saving the new alerting step succeeds" do
      before :each do
        perform
      end

      subject { assigns(:alerting_step) }
      it { should_not be_nil }
      it { should be_persisted }
      its(:rotation_membership) { should eql(@rotation_membership) }

      specify { response.should redirect_to [@rotation_membership, assigns(:alerting_step)] }
    end

    context "when saving the new alerting step fails" do
      before :each do
        AlertingStep.any_instance.stubs(:save).returns(false)
        perform
      end

      subject { assigns(:alerting_step) }
      it { should_not be_nil }
      it { should be_new_record }

      specify { response.should render_template("new") }
    end
  end

  describe "#edit" do
    before :each do
      with_user @user do
        get :edit, :id => @alerting_step.id, :rotation_membership_id => @rotation_membership.id
      end
    end

    subject { assigns(:alerting_step) }
    it { should_not be_nil }
    it { should eql(@alerting_step) }
    its(:rotation_membership) { should eql(@rotation_membership) }

    specify { response.should render_template("edit") }
  end

  describe "#update" do
    let(:perform) {
      with_user @user do
        put :update, :id => @alerting_step.id, :alerting_step => @alerting_step.attributes,
            :rotation_membership_id => @rotation_membership.id
      end
    }

    context "when updating the alerting step succeeds" do
      before :each do
        perform
      end

      subject { assigns(:alerting_step) }
      it { should_not be_nil }
      it { should eql(@alerting_step) }
      its(:rotation_membership) { should eql(@rotation_membership) }

      specify { response.should redirect_to [@rotation_membership, @alerting_step] }
    end

    context "when updating the alerting step fails" do
      before :each do
        AlertingStep.any_instance.stubs(:update_attributes).returns(false)
        perform
      end

      subject { assigns(:alerting_step) }
      it { should_not be_nil }
      it { should eql(@alerting_step) }
      its(:rotation_membership) { should eql(@rotation_membership) }

      specify { response.should render_template("edit") }
    end
  end

  describe "#destroy" do
    before :each do
      with_user @user do
        delete :destroy, :id => @alerting_step.id, :rotation_membership_id => @rotation_membership.id
      end
    end

    subject { assigns(:alerting_step) }
    it { should_not be_nil }
    it { should eql(@alerting_step) }
    it { should be_destroyed }
    its(:rotation_membership) { should eql(@rotation_membership) }
  end
end
