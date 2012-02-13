require 'spec_helper'

describe EscalationJob do
  describe "#perform" do
    let(:issue) {
      FactoryGirl.create(:issue)
    }
    let(:escalation_policy) {
      FactoryGirl.create(:escalation_policy)
    }
    let(:rotation) {
      FactoryGirl.create(:rotation)
    }
    let(:user) {
      FactoryGirl.create(:user)
    }
    let(:job) {
      EscalationJob.new(issue.id)
    }

    context "when issue can't be found" do
      let(:issue) {
        issue = FactoryGirl.create(:issue)
        issue.destroy
      }

      specify do
        expect { job.perform }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "when issue.status != :open" do
      let(:issue) {
        FactoryGirl.create(:issue, :status => :unknown)
      }

      before :each do
        Issue.any_instance.expects(:save).never
        Delayed::Job.expects(:enqueue).never
      end

      it "should silently return" do
        job.perform
      end
    end

    context "when given correct input" do
      let(:issue) {
        FactoryGirl.create(:issue, :escalation_policy => escalation_policy)
      }
      let(:escalation_policy) {
        FactoryGirl.create(:escalation_policy)
      }

      it "should work" do
        rotation_membership = FactoryGirl.create(:rotation_membership, :rotation => rotation, :user => user)
        FactoryGirl.create(:escalation_step, :escalation_policy => escalation_policy, :rotation => rotation)
        FactoryGirl.create(:escalation_step, :escalation_policy => escalation_policy, :rotation => rotation,
            :delay_minutes => 5)

        Delayed::Job.expects(:enqueue).with(kind_of(EscalationJob), 0, kind_of(Time)).once
        Delayed::Job.expects(:enqueue).with(kind_of(AlertingJob)).once

        job.perform
      end
    end
  end

  describe "#error" do
    let(:issue) {
      FactoryGirl.create(:issue)
    }

    it "should fail the job on ActiveRecord::RecordNotFound" do
      job = mock()
      job.stubs(:id).returns(0)
      job.stubs(:name).returns("testjob")
      job.expects(:fail!)

      EscalationJob.new(issue.id).error(job, ActiveRecord::RecordNotFound.new)
    end
  end
end
