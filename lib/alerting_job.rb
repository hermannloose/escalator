class AlertingJob < Struct.new(:rotation_membership_id, :issue_id)
  def perform
    rotation_membership = RotationMembership.find(rotation_membership_id)
    user = rotation_membership.user
    issue = Issue.find(issue_id)

    # Issue was escalated in the meantime, drop this job silently.
    return if issue.assignee != user

    delay = (Time.now - issue.posted_at) / 60
    steps = rotation_membership.alerting_steps.ordered.all
    current_step = steps.reverse.find { |step| step.delay_minutes <= delay }
    # TODO(hermannloose): Validate that there is always a first step.
    return unless current_step
    upcoming = steps.find { |step| step.delay_minutes > delay }

    check_after = upcoming ? upcoming.delay_minutes - delay : nil
    if check_after
      Delayed::Job.enqueue(AlertingJob.new(rotation_membership_id, issue_id), {
        :priority => 0,
        :run_at => check_after.minutes.from_now
      })
    end

    contact = current_step.contact_detail

    Service.invoke(contact.category.to_sym, {
      :user => user
    }, issue)
  end

  def error(job, exception)
    Rails.logger.warn "#{exception}"

    case exception
    when ArgumentError
      # Do not attempt to run again.
      job.fail!
    end
  end
end
