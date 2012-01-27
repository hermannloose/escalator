require 'spec_helper'

describe UsersController do
  render_views
  setup_mapping

  before :each do
    @admin = Factory(:admin)
    sign_in @admin
  end

  context "when guest" do
    it "should deny all access" do
      with_user nil do
        should_not_be_allowed_to :index, :users
        should_not_be_allowed_to :show, :users
        should_not_be_allowed_to :new, :users
        should_not_be_allowed_to :create, :users
        should_not_be_allowed_to :edit, :users
        should_not_be_allowed_to :update, :users
        should_not_be_allowed_to :destroy, :users
      end
    end
  end

  context "when user" do
    it "should allow read-only access" do
      @user = Factory(:user)
      sign_in @user
      with_user @user do
        should_be_allowed_to :index, :users
        should_be_allowed_to :show, :users

        should_not_be_allowed_to :new, :users
        should_not_be_allowed_to :create, :users
        should_not_be_allowed_to :edit, :users
        should_not_be_allowed_to :update, :users
        should_not_be_allowed_to :destroy, :users
      end
    end
  end

  context "when admin" do
    it "should allow all access" do
      with_user @admin do
        should_be_allowed_to :index, :users
        should_be_allowed_to :show, :users
        should_be_allowed_to :new, :users
        should_be_allowed_to :create, :users
        should_be_allowed_to :edit, :users
        should_be_allowed_to :update, :users
        should_be_allowed_to :destroy, :users
      end
    end
  end

  describe "#index" do
    before :each do
      with_user(@admin) do
        get :index
      end
    end

    specify { assigns(:users).should_not be_nil }
    specify { response.should render_template("index") }
  end

  describe "#show" do
    before :each do
      @user = Factory(:user)

      with_user(@admin) do
        get :show, :id => @user.to_param
      end
    end

    it "should get the user for the given id" do
      assigns(:user).should eql(@user)
    end
    specify { response.should render_template("show") }
  end

  describe "#new" do
    before :each do
      with_user(@admin) do
        get :new
      end

      @user = assigns(:user)
    end

    specify { @user.should_not be_nil }
    specify { @user.should be_new_record }
    specify { response.should render_template("new") }
  end

  describe "#create" do
    before :each do
      @user_hash = {
        :name => "Test user to be created",
        :email => "mail@example.com",
        :password => "password",
        :password_confirmation => "password"
      }
    end

    context "when password is blank" do
      before :each do
        @user_hash.delete :password

        with_user(@admin) do
          post :create, :user => @user_hash
        end
      end

      specify { assigns(:user).should be_new_record }
      specify { response.should render_template("new") }
    end

    context "when password confirmation does not match" do
      before :each do
        @user_hash[:password_confirmation] = "wrong"

        with_user(@admin) do
          post :create, :user => @user_hash
        end
      end

      specify { assigns(:user).should be_new_record }
      specify { response.should render_template("new") }
    end

    context "when given valid parameters" do
      before :each do
        with_user(@admin) do
          post :create, :user => @user_hash
        end
      end

      specify { assigns(:user).should be_persisted }
      specify { response.should redirect_to user_path(assigns(:user)) }
    end
  end

  describe "#edit" do
    before :each do
      @user = Factory(:user)

      with_user(@admin) do
        get :edit, :id => @user.to_param
      end
    end

    it "should get the user for the given id" do
      assigns(:user).should eql(@user)
    end
    specify { response.should render_template("edit") }
  end

  describe "#update" do
    before :each do
      @user = Factory(:user)

      with_user(@admin) do
        post :update, :id => @user.to_param, :user => @user.attributes
      end
    end

    it "should get the user for the given id" do
      assigns(:user).should eql(@user)
    end
    specify { response.should redirect_to user_path(@user) }
  end

  describe "#destroy" do
    before :each do
      @user = Factory(:user)

      with_user(@admin) do
        delete :destroy, :id => @user.to_param
      end
    end

    specify { assigns(:user).should be_new_record }
    specify { response.should redirect_to users_path }
  end
end
