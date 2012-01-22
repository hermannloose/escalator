require 'spec_helper'

describe GoogleClientLoginController do
  render_views

  describe :new do
    before :each do
      get :new
    end

    specify { response.should render_template("new") }
  end

  describe :create do
    let(:email) { "present" }
    let(:password) { "present" }
    let(:create) do
      post :create, :email => email, :password => password
    end

    context "when parameter :email is missing" do
      let(:email) { nil }

      specify { lambda { create }.should raise_error ArgumentError }

      it "should not attempt to acquire a token" do
        RestClient.expects(:post).never

        begin
          create
        rescue ArgumentError
          # Expected.
        end
      end
    end

    context "when parameter :password is missing" do
      let(:password) { nil }

      specify { lambda { create }.should raise_error ArgumentError }

      it "should not attempt to acquire a token" do
        RestClient.expects(:post).never

        begin
          create
        rescue ArgumentError
          # Expected.
        end
      end
    end

    context "when given valid parameters" do
      let(:resp) { mock() }

      before :each do
        resp.expects(:code).returns(resp_code)
        RestClient.expects(:post).yields(resp, nil, nil)
      end

      context "when the call to Google returns HTTP 200" do
        let(:resp_code) { 200 }
        let(:resp_body) { "somethingsomethingAuth=foobar\nsomethingsomething" }
        let(:credentials) { mock() }

        before :each do
          resp.expects(:body).returns(resp_body)

          credentials.expects(:token=).with("foobar")
          credentials.stubs(:save).returns(true)
          GoogleClientLoginCredentials.expects(:find_or_create_by_email).
              with(email).returns(credentials)

          create
        end

        it "should render the index page" do
          response.should redirect_to google_client_login_credentials_index_path
        end

        it "should set a success message" do
          flash[:notice].should eql "Token acquired."
        end
      end

      context "when the call to Google returns HTTP 403" do
        let(:resp_code) { 403 }
        let(:resp_body) { "" }

        pending "should handle the error appropriately"
      end
    end
  end

  describe :destroy do
    before :each do
      credentials = mock()
      credentials.expects(:destroy)
      GoogleClientLoginCredentials.expects(:find).with("id").returns(credentials)
      delete :destroy, :id => "id"
    end

    specify { response.should redirect_to google_client_login_credentials_index_path }
  end
end
