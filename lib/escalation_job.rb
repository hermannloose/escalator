class EscalationJob < Struct.new(:issue_id)
  def perform
    issue = Issue.find(issue_id)
    # TODO(hermannloose): Update once there is a defined set of states.
    return unless issue.status.intern == :open

    escalate_to = issue.escalation_policy.escalation_steps.passed(issue.delayed.minutes).last
    upcoming = issue.escalation_policy.escalation_steps.upcoming(issue.delayed.minutes).first
    # TODO(hermannloose): Write log record when escalation stops.
    check_after = nil
    if upcoming
      check_after = upcoming.delay_minutes - issue.delayed.minutes
      Delayed::Job.enqueue(EscalationJob.new(issue_id), 0, check_after.minutes.from_now)
    end

    oncall = escalate_to.rotation.rotation_memberships.first
    unless issue.assignee == oncall.user
      old_assignee = issue.assignee
      issue.assignee = oncall.user
      issue.save

      #AssigneeMailer.escalated_mail(old_assignee, issue).deliver if old_assignee
      Delayed::Job.enqueue(AlertingJob.new(oncall.to_param, issue.to_param))
    end
  end
end
