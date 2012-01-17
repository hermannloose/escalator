class AlertingJob < Struct.new(:rotation_membership_id, :issue_id)
  def perform
    rotation_membership = RotationMembership.find(rotation_membership_id)
    user = rotation_membership.user
    issue = Issue.find(issue_id)

    # Issue was escalated in the meantime, drop this job silently.
    return if issue.assignee != user

    delay = (Time.now - issue.posted_at) / 60
    steps = rotation_membership.alerting_steps.ordered.all
    use_contact = steps.reverse.find { |step| step.delay_minutes <= delay }.contact_detail
    upcoming = steps.find { |step| step.delay_minutes > delay }

    check_after = upcoming ? upcoming.delay_minutes - delay : nil

    if check_after Delayed::Job.enqueue(AlertingJob.new(rotation_membership_id, issue_id), 0, check_after)

    # TODO(hermannloose): Use use_contact to actually alert the user.
  end
end
