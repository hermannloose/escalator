require 'spec_helper'

describe Service::Email do
  describe "#perform" do
    it "should call the AssigneeMailer" do
      params = mock()
      mail = mock()
      AssigneeMailer.expects(:assignee_mail).with(params).returns(mail)
      mail.expects(:deliver)

      Service::Email.perform(params)
    end
  end
end
