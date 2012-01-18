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
    if check_after
      Delayed::Job.enqueue(AlertingJob.new(rotation_membership_id, issue_id), {
        :priority => 0,
        :run_at => check_after.minutes.from_now
      })
    end

    # TODO(hermannloose): Use use_contact to actually alert the user.
    case use_contact.category
    when "email"
      AssigneeMailer.assignee_mail(user, issue).deliver
    else
      raise "Unknown category #{use_contact.category}.", ArgumentError
    end
  end
end
