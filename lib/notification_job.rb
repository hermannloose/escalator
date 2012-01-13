class NotificationJob < Struct.new(:user_id)
  def perform
    user = User.find(user_id)
    # TODO(hermannloose): Implement notification logic.
    # This could initially bypass the alerting steps and just send an email for
    # testing and demonstration.
  end
end
