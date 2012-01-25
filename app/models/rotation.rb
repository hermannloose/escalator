class Rotation < ActiveRecord::Base
  has_many :rotation_memberships
  has_many :users, :through => :rotation_memberships, :order => "rank"
  # Handle to the currently pending RotationJob.
  # TODO(hermannloose): If :rotate_every is changed, this job should be killed.
  belongs_to :delayed_job

  validates :name, :presence => true
  validates :rotate_every, :numericality => {
    :only_integer => true,
    # Schedule RotationJobs at least 15 minutes apart.
    #
    # Smaller values are not really practical and I would like to avoid
    # concurrency bugs at least for now. -hermannloose
    :greater_than_or_equal_to => 900
  }
end
