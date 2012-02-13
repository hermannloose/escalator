require 'spec_helper'

describe IssuesController do
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
  let(:issue) {
    FactoryGirl.create(:issue)
  }

  context "when guest" do
    it "should deny all access" do
      with_user nil do
        should_not_be_allowed_to :index, :issues
        should_not_be_allowed_to :show, :issues
        should_not_be_allowed_to :new, :issues
        should_not_be_allowed_to :create, :issues
        should_not_be_allowed_to :edit, :issues
        should_not_be_allowed_to :update, :issues
        should_not_be_allowed_to :destroy, :issues
      end
    end
  end

  context "when user" do
    it "should allow read-only access and creating new issues" do
      with_user(user) do
        should_be_allowed_to :index, :issues
        should_be_allowed_to :show, :issues
        should_be_allowed_to :new, :issues
        should_be_allowed_to :create, :issues
        should_not_be_allowed_to :edit, :issues
        should_not_be_allowed_to :update, :issues
        should_not_be_allowed_to :destroy, :issues
      end
    end
  end

  context "when admin" do
    it "should allow all access" do
      with_user(admin) do
        should_be_allowed_to :index, :issues
        should_be_allowed_to :show, :issues
        should_be_allowed_to :new, :issues
        should_be_allowed_to :create, :issues
        should_be_allowed_to :edit, :issues
        should_be_allowed_to :update, :issues
        should_be_allowed_to :destroy, :issues
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
        get :show, :id => issue.id
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
    let(:issue) {
      FactoryGirl.build(:issue)
    }

    let(:perform) {
      with_user(admin) do
        post :create, :issue => issue.attributes
      end
    }

    context "when saving the issue succeeds" do
      before :each do
        perform
      end

      subject { assigns(:issue) }

      it { should_not be_nil }
      it { should be_persisted }
      specify { response.should redirect_to subject }
    end

    context "when saving the issue fails" do
      before :each do
        Issue.any_instance.stubs(:save).returns(false)
        perform
      end

      subject { assigns(:issue) }

      it { should_not be_nil }
      it { should be_new_record }
      specify { response.should render_template("new") }
    end
  end

  describe "#edit" do
    before :each do
      with_user(admin) do
        get :edit, :id => issue.id
      end
    end

    specify { response.should render_template("edit") }
  end

  describe "#update" do
    let(:perform) {
      with_user(admin) do
        put :update, :id => issue.id, :issue => issue.attributes
      end
    }

    context "when updating the issue succeeds" do
      before :each do
        perform
      end

      subject { assigns(:issue) }

      it { should_not be_nil }
      it { should be_persisted }
      specify { response.should redirect_to subject }
    end

    context "when updating the issue fails" do
      before :each do
        Issue.any_instance.stubs(:update_attributes).returns(false)
        perform
      end

      subject { assigns(:issue) }

      it { should_not be_nil }
      it { should be_persisted }
      specify { response.should render_template("edit") }
    end
  end

  describe "#destroy" do
    before :each do
      with_user(admin) do
        delete :destroy, :id => issue.id
      end
    end

    subject { assigns(:issue) }

    it { should_not be_nil }
    it { should_not be_persisted }
    specify { response.should redirect_to :issues }
  end
end
