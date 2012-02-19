require 'spec_helper'

describe AlertingJob do
  let(:rotation_membership) {
    rotation_membership = FactoryGirl.create(:rotation_membership, :user => user)
    FactoryGirl.create(:alerting_step,
        :delay_minutes => 0,
        :contact_detail => FactoryGirl.create(:contact_detail,
            :category => :email,
            :details => { "foo" => "bar" },
            :user => user),
        :rotation_membership => rotation_membership)

    rotation_membership
  }
  let(:issue) {
    FactoryGirl.create(:issue, :assignee => user)
  }
  let(:user) {
    FactoryGirl.create(:user)
  }

  describe "#perform" do
    let(:job) {
      AlertingJob.new(rotation_membership.id, issue.id)
    }

    context "when issue.assignee is nil" do
      let(:issue) {
        FactoryGirl.create(:issue)
      }

      it "should silently return" do
        job.perform
      end
    end

    context "when issue.assignee != user" do
      let(:issue) {
        issue = FactoryGirl.create(:issue)
        issue.assignee = FactoryGirl.create(:user)
        issue
      }

      it "should silently return" do
        job.perform
      end
    end

    context "when there is no currently active alerting step" do
      let(:rotation_membership) {
        FactoryGirl.create(:rotation_membership, :user => user)
      }

      it "should fail" do
        expect { job.perform }.to raise_error(RuntimeError)
      end
    end

    context "when everything is just right" do
      it "should invoke the service" do
        Service.expects(:invoke).with(:email, {
            :foo => "bar",
            :user => user,
            :issue => issue })

        job.perform
      end
    end
  end

  describe "#error" do
    it "should fail the job on ArgumentError" do
      job = mock()
      job.stubs(:id).returns(0)
      job.stubs(:name).returns("testjob")
      job.expects(:fail!)

      AlertingJob.new(rotation_membership.id, issue.id).error(job, ArgumentError.new)
    end
  end
end
