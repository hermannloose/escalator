class EscalationJob < Struct.new(:issue_id)
  def perform
    issue = Issue.find(issue_id)
    # TODO(hermannloose): Update once there is a defined set of states.
    return unless issue.status.intern == :open

    elapsed_minutes = (Time.now - issue.posted_at) / 60
    escalate_to = issue.escalation_policy.escalation_steps.passed(elapsed_minutes).last
    upcoming = issue.escalation_policy.escalation_steps.upcoming(elapsed_minutes).first
    # TODO(hermannloose): Write log record when escalation stops.
    check_after = nil
    if upcoming
      check_after = upcoming.delay_minutes - elapsed_minutes
      Delayed::Job.enqueue(EscalationJob.new(issue_id), 0, check_after.minutes.from_now)
    end

    oncall = escalate_to.rotation.users.first
    unless issue.assignee == oncall
      old_assignee = issue.assignee
      issue.assignee = oncall
      issue.save

      AssigneeMailer.assignee_mail(oncall, issue, check_after).deliver
      AssigneeMailer.escalated_mail(old_assignee, issue).deliver if old_assignee
      #Delayed::Job.enqueue(NotificationJob.new(oncall.to_param))
    end
  end
end
