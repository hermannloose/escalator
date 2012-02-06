class EscalationJob < Struct.new(:issue_id)
  def perform
    issue = Issue.find(issue_id)
    delayed_minutes = issue.delayed / 60
    # TODO(hermannloose): Update once there is a defined set of states.
    return unless issue.status.intern == :open

    escalate_to = issue.escalation_policy.escalation_steps.passed(delayed_minutes).last
    # TODO(hermannloose): Test.
    unless escalate_to
      raise RuntimeError, "No currently active escalation step."
    end
    upcoming = issue.escalation_policy.escalation_steps.upcoming(delayed_minutes).first
    # TODO(hermannloose): Write log record when escalation stops.
    check_after = nil
    if upcoming
      check_after = upcoming.delay_minutes - delayed_minutes
      Delayed::Job.enqueue(EscalationJob.new(issue_id), 0, check_after.minutes.from_now)
    end

    oncall = escalate_to.rotation.rotation_memberships.first
    # TODO(hermannloose): Test.
    unless oncall
      raise RuntimeError, "No on-call user found."
    end
    unless issue.assignee == oncall.user
      old_assignee = issue.assignee
      issue.assignee = oncall.user
      issue.save

      #AssigneeMailer.escalated_mail(old_assignee, issue).deliver if old_assignee
      Delayed::Job.enqueue(AlertingJob.new(oncall.to_param, issue.to_param))
    end
  end
end
