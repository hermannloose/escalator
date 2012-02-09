class AlertingJob < Struct.new(:rotation_membership_id, :issue_id)
  def perform
    rotation_membership = RotationMembership.find(rotation_membership_id)
    user = rotation_membership.user
    issue = Issue.find(issue_id)

    # Issue was escalated in the meantime, drop this job silently.
    return if issue.assignee != user

    delay_minutes = issue.delayed / 60
    steps = rotation_membership.alerting_steps.ordered.all
    current_step = steps.reverse.find { |step| step.delay_minutes <= delay_minutes }
    # TODO(hermannloose): Validate that there is always a first step.
    unless current_step
      raise RuntimeError, "No currently active alerting step. (delay: #{delay_minutes}, membership: #{rotation_membership_id})"
    end
    upcoming = steps.find { |step| step.delay_minutes > delay_minutes }

    check_after = upcoming ? upcoming.delay_minutes - delay_minutes : nil
    if check_after
      Rails.logger.info "Scheduling new alert for #{check_after.minutes.from_now}."

      Delayed::Job.enqueue(AlertingJob.new(rotation_membership_id, issue_id), {
        :priority => 0,
        :run_at => check_after.minutes.from_now
      })
    end

    # TODO(hermannloose): Clean up the naming mess below.
    contact = current_step.contact_detail
    Rails.logger.debug "Contact: " + contact.inspect + " #details: " + contact.details.inspect
    details = Hash.new
    contact.details.each do |key, value|
      details[key.to_sym] = value
    end
    details[:user] = user
    details[:issue] = issue

    Service.invoke(contact.category.to_sym, details)
  end

  def error(job, exception)
    case exception
    when ArgumentError
      Rails.logger.warn "##{job.id} #{job.name}: caught ArgumentError, will not retry."
      # Do not attempt to run again.
      job.fail!
    end
  end
end
