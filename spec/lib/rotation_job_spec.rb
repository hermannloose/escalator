require 'spec_helper'
require 'rotation_job'

describe RotationJob do
  describe "#perform" do
    before :each do
      @now = Time.now
      @rotation = Factory(:rotation)
    end

    it "should rotate the users in the rotation" do
      users = FactoryGirl.create_list(:user, 5)
      rank = 0
      users.each do |user|
        Factory(:rotation_membership,
            :rotation => @rotation,
            :user => user,
            :rank => rank)
        rank += 1
      end

      Delayed::Job.enqueue(RotationJob.new(@rotation.to_param))

      successful, failed = Delayed::Worker.new.work_off

      successful.should eql(1)
      failed.should eql(0)

      # TODO(hermannloose): Change to use Array#rotate with Ruby 1.9.3.
      @rotation.reload.users.should eql(users[4..4] + users[0..3])
    end

    it "should schedule a new RotationJob" do
      Delayed::Job.enqueue(RotationJob.new(@rotation.to_param))

      successful, failed = Delayed::Worker.new.work_off

      successful.should eql(1)
      failed.should eql(0)

      Delayed::Job.count.should eql(1)
      Delayed::Job.first.name.should eql("RotationJob")
    end

    it "should not drift" do
      # rotate_every defaults to 1000 in factory
      schedule_base = 500.seconds.until(@now)
      Delayed::Job.enqueue(RotationJob.new(@rotation.to_param),
          :priority => 0,
          :run_at => schedule_base)

      successful, failed = Delayed::Worker.new.work_off

      successful.should eql(1)
      failed.should eql(0)

      Delayed::Job.first.run_at.should eql(500.seconds.since(@now))
    end
  end
end
