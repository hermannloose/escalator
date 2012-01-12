class EscalationJob < Struct.new(:issue_id)
  def perform
    issue = Issue.find(issue_id)
    # TODO(hermannloose): Update once there is a defined set of states.
    return if issue.status == 'acknowledged'

    elapsed_minutes = (Time.now - issue.posted_at) / 60
    escalate_to = issue.escalation_policy.escalation_steps.passed(elapsed_minutes).last
    upcoming = issue.escalation_policy.escalation_steps.upcoming(elapsed_minutes).first
    # TODO(hermannloose): Write log record when escalation stops.
    unless upcoming.nil?
      check_after = elapsed_minutes - upcoming.delay_minutes
      Delayed::Job.enqueue(EscalationJob.new(issue_id), 0, check_after.minutes.from_now)
    end

    oncall = escalate_to.rotation.users.first
    issue.assignee = oncall
    issue.save!

    Delayed::Job.enqueue(NotificationJob.new(oncall.to_param))
  end
end
