require 'test_helper'

class IssueTest < ActiveSupport::TestCase
  setup do
    @issue = issues(:valid)
  end

  test "should save valid issue" do
    assert @issue.save
  end

  test "should validate presence of escalation_policy" do
    @issue.escalation_policy = nil
    assert !@issue.save
  end

  test "should validate presence of title" do
    @issue.title = nil
    assert !@issue.save
  end

  test "should validate presence of status" do
    @issue.status = nil
    assert !@issue.save
  end
end
