require 'test_helper'

class AlertingJobTest < ActiveSupport::TestCase
  setup do
    @rotation_membership = rotation_memberships(:r1u1)
  end

  test "should silently drop job if issue assignee is nil" do
    issue = issues(:one)

    Delayed::Job.enqueue(AlertingJob.new(@rotation_membership.to_param, issue.to_param))

    successful, failed = Delayed::Worker.new.work_off
    assert_equal [1, 0], [successful, failed]
  end

  test "should silently drop job if issue assignee does not match" do
    issue = issues(:age1_assignee2_open)

    Delayed::Job.enqueue(AlertingJob.new(@rotation_membership.to_param, issue.to_param))

    successful, failed = Delayed::Worker.new.work_off
    assert_equal [1, 0], [successful, failed]
  end

  test "should send mail for category 'email'" do
    issue = issues(:age1_assignee1_open)

    Delayed::Job.enqueue(AlertingJob.new(@rotation_membership.to_param, issue.to_param))

    assert_difference("ActionMailer::Base.deliveries.size", 1) do
      successful, failed = Delayed::Worker.new.work_off
      assert_equal [1, 0], [successful, failed]
    end
  end

  test "should fail for unknown category" do
    issue = issues(:age5_assignee1_open)

    Delayed::Job.enqueue(AlertingJob.new(@rotation_membership.to_param, issue.to_param))

    assert_no_difference("ActionMailer::Base.deliveries.size") do
      successful, failed = Delayed::Worker.new.work_off
      assert_equal [0, 1], [successful, failed]
      assert_equal 1, Delayed::Job.all.size
      assert Delayed::Job.first.failed?
    end
  end
end
