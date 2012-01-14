require 'test_helper'

class AssigneeMailerTest < ActionMailer::TestCase
  setup do
    @user = users(:one)
    @issue = issues(:one)
  end

  test "should send assignee_mail" do
    assert_difference("ActionMailer::Base.deliveries.size", 1) do
      AssigneeMailer.assignee_mail(@user, @issue).deliver
    end

    mail = ActionMailer::Base.deliveries.first

    assert_equal @user.email, mail.to[0]
    assert_equal "Issue #{@issue.to_param} has been assigned to you!", mail.subject
    assert_match /Dear #{@user.name}/, mail.body
  end

  test "should send escalated_mail" do
    assert_difference("ActionMailer::Base.deliveries.size", 1) do
      AssigneeMailer.escalated_mail(@user, @issue).deliver
    end

    mail = ActionMailer::Base.deliveries.first

    assert_equal @user.email, mail.to[0]
    assert_equal "Issue #{@issue.to_param} has been escalated!", mail.subject
    assert_match /Dear #{@user.name}/, mail.body
  end

end
