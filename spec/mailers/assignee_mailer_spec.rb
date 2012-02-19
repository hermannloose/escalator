require 'spec_helper'

describe AssigneeMailer do
  describe "#assignee_mail" do
    let(:user) { FactoryGirl.create(:user) }
    let(:email) { "mail@example.com" }
    let(:issue) { FactoryGirl.create(:issue) }

    let(:perform) {
      AssigneeMailer.assignee_mail(
          :user => user,
          :email => email,
          :issue => issue).deliver
    }

    context "when no user is given" do
      let(:user) { nil }

      it "should raise an ArgumentError" do
        expect { perform }.to raise_error(ArgumentError)
      end
    end

    context "when no email address is given" do
      let(:email) { nil }

      it "should raise an ArgumentError" do
        expect { perform }.to raise_error(ArgumentError)
      end
    end

    context "when no issue is given" do
      let(:issue) { nil }

      it "should raise an ArgumentError" do
        expect { perform }.to raise_error(ArgumentError)
      end
    end

    context "when given valid parameters" do
      before :each do
        perform
      end

      it "should deliver one email" do
        ActionMailer::Base.deliveries.size.should eql(1)
      end

      subject { ActionMailer::Base.deliveries.first }

      its(:subject) { should eql("Issue #{issue.to_param} has been assigned to you!") }
      its(:body) { should match(/Dear #{user.name}/) }
    end
  end

  describe "#escalated_mail" do
    let(:user) { FactoryGirl.create(:user) }
    let(:email) { "mail@example.com" }
    let(:issue) { FactoryGirl.create(:issue) }

    let(:perform) {
      AssigneeMailer.escalated_mail(
          :user => user,
          :email => email,
          :issue => issue).deliver
    }

    context "when no user is given" do
      let(:user) { nil }

      it "should raise an ArgumentError" do
        expect { perform }.to raise_error(ArgumentError)
      end
    end

    context "when no email address is given" do
      let(:email) { nil }

      it "should raise an ArgumentError" do
        expect { perform }.to raise_error(ArgumentError)
      end
    end

    context "when no issue is given" do
      let(:issue) { nil }

      it "should raise an ArgumentError" do
        expect { perform }.to raise_error(ArgumentError)
      end
    end

    context "when given valid parameters" do
      before :each do
        perform
      end

      it "should deliver one email" do
        ActionMailer::Base.deliveries.size.should eql(1)
      end

      subject { ActionMailer::Base.deliveries.first }

      its(:subject) { should eql("Issue #{issue.to_param} has been escalated!") }
      its(:body) { should match(/Dear #{user.name}/) }
    end
  end
end
