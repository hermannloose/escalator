require 'spec_helper'

describe Service::Android do
  describe "#perform" do
    let(:issue) { mock() }
    let(:credentials) { mock() }

    let(:params) {
      { :registration_id => "foo", :issue => issue }
    }

    let(:resp) { mock() }
    let(:request) { mock() }
    let(:result) { mock() }

    let(:perform) {
      Service::Android.perform(params)
    }

    before :each do
      credentials.stubs(:token).returns("token")
      GoogleClientLoginCredentials.stubs(:first).returns(credentials)
      issue.expects(:to_json).returns("bar")
      RestClient.expects(:post).with(
          "https://android.apis.google.com/c2dm/send",
          anything,
          anything).once.yields(resp, request, result)
    end

    context "when the response is HTTP 200" do
      before :each do
        resp.stubs(:code).returns(200)
      end

      context "when there were no errors" do
        before :each do
          resp.stubs(:body).returns("")
        end

        it "should work" do
          perform
        end
      end

      context "when there were errors" do
        before :each do
          resp.stubs(:body).returns("Error=foobar")
        end

        specify {
          expect { perform }.to raise_error(RuntimeError)
        }
      end
    end

    context "when the response is HTTP 401" do
      before :each do
        resp.stubs(:code).returns(401)
      end

      specify {
        expect { perform }.to raise_error(RuntimeError)
      }
    end

    context "when the response is some other HTTP status" do
      before :each do
        resp.stubs(:code).returns(0)
      end

      specify {
        expect { perform }.to raise_error(RuntimeError)
      }
    end
  end
end
