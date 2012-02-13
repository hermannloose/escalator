require 'spec_helper'

describe ContactDetailsController do
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
  let(:contact_detail) {
    FactoryGirl.create(:contact_detail, :user => user)
  }

  context "when guest" do
    it "should deny all access" do
      with_user nil do
        should_not_be_allowed_to :index, :contact_details
        should_not_be_allowed_to :show, :contact_details
        should_not_be_allowed_to :new, :contact_details
        should_not_be_allowed_to :create, :contact_details
        should_not_be_allowed_to :edit, :contact_details
        should_not_be_allowed_to :update, :contact_details
        should_not_be_allowed_to :destroy, :contact_details
      end
    end
  end

  context "when user" do
    it "should allow access to own contact details" do
      other_detail = FactoryGirl.create(:contact_detail)
      with_user(user) do
        should_be_allowed_to :index, contact_detail
        should_be_allowed_to :show, contact_detail
        should_be_allowed_to :new, contact_detail
        should_be_allowed_to :create, contact_detail
        should_be_allowed_to :edit, contact_detail
        should_be_allowed_to :update, contact_detail
        should_be_allowed_to :destroy, contact_detail

        should_not_be_allowed_to :index, other_detail
        should_not_be_allowed_to :show, other_detail
        should_not_be_allowed_to :new, other_detail
        should_not_be_allowed_to :create, other_detail
        should_not_be_allowed_to :edit, other_detail
        should_not_be_allowed_to :update, other_detail
        should_not_be_allowed_to :destroy, other_detail
      end
    end
  end

  context "when admin" do
    it "should allow all access" do
      with_user(admin) do
        should_be_allowed_to :index, :contact_details
        should_be_allowed_to :show, :contact_details
        should_be_allowed_to :new, :contact_details
        should_be_allowed_to :create, :contact_details
        should_be_allowed_to :edit, :contact_details
        should_be_allowed_to :update, :contact_details
        should_be_allowed_to :destroy, :contact_details
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
        get :show, :id => contact_detail.id
      end
    end

    subject { assigns(:contact_detail) }

    it { should_not be_nil }
    it { should eql(contact_detail) }
    specify { response.should render_template("show") }
  end

  describe "#new" do
    before :each do
      with_user(admin) do
        get :new
      end
    end

    subject { assigns(:contact_detail) }

    it { should_not be_nil }
    it { should be_new_record }
    specify { response.should render_template("new") }
  end

  describe "#create" do
    let(:contact_detail) {
      FactoryGirl.build(:contact_detail, :user => user)
    }

    let(:perform) {
      with_user(user) do
        post :create, :contact_detail => contact_detail.attributes
      end
    }

    context "when saving the contact detail succeeds" do
      before :each do
        perform
      end

      subject { assigns(:contact_detail) }
      it { should_not be_nil }
      it { should be_persisted }
      specify { response.should redirect_to [:profile, subject] }
    end

    context "when saving the contact detail fails" do
      before :each do
        ContactDetail.any_instance.stubs(:save).returns(false)
        perform
      end

      subject { assigns(:contact_detail) }
      it { should_not be_nil }
      it { should be_new_record }
      specify { response.should render_template("new") }
    end
  end

  describe "#edit" do
    before :each do
      with_user(user) do
        get :edit, :id => contact_detail.id
      end
    end

    subject { assigns(:contact_detail) }

    it { should_not be_nil }
    it { should eql(contact_detail) }
    specify { response.should render_template("edit") }
  end

  describe "#update" do
    let(:perform) {
      with_user(user) do
        put :update, :id => contact_detail.id, :contact_detail => contact_detail.attributes
      end
    }

    context "when updating the contact detail succeeds" do
      before :each do
        perform
      end

      subject { assigns(:contact_detail) }
      it { should_not be_nil }
      it { should be_persisted }
      specify { response.should redirect_to [:profile, subject] }
    end

    context "when updating the contact detail fails" do
      before :each do
        ContactDetail.any_instance.stubs(:update_attributes).returns(false)
        perform
      end

      subject { assigns(:contact_detail) }
      it { should_not be_nil }
      it { should be_persisted }
      specify { response.should render_template("edit") }
    end
  end

  describe "#destroy" do
    before :each do
      with_user(user) do
        delete :destroy, :id => contact_detail.id
      end
    end

    subject { assigns(:contact_detail) }
    it { should_not be_nil }
    it { should_not be_persisted }
    specify { response.should redirect_to [:profile, :contact_details] }
  end
end
