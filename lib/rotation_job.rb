class RotationJob < Struct.new(:rotation_id)
  def before(job)
    # Use job.run_at instead of Time.now to prevent drift.
    @schedule_base = job.run_at
  end

  def perform
    rotation = Rotation.includes(:rotation_memberships).find(rotation_id)

    memberships = rotation.rotation_memberships
    memberships.each do |membership|
      membership.rank = (membership.rank + 1) % memberships.size
    end
    RotationMembership.transaction do
      memberships.each { |membership| membership.save! }
    end

    Delayed::Job.enqueue(RotationJob.new(rotation_id),
        :priority => 0,
        :run_at => rotation.rotate_every.seconds.since(@schedule_base))
  end
end
