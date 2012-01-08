require 'test_helper'

class IssueTest < ActiveSupport::TestCase
  test "should validate presence of title" do
    issue = Issue.new
    issue.status = "present"
    assert !issue.save
  end

  test "should validate presence of status" do
    issue = Issue.new
    issue.title = "present"
    assert !issue.save
  end
end
