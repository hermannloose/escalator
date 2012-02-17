module EscalationPolicySteps
  def add_escalation_policy(fields)
    fields = parse_fields(fields)

    visit new_escalation_policy_path

    if fields
      fill_in "Name", :with => fields["name"]
    else
      fill_in "Name", :with => "Test Policy"
    end
    click_on "Create Escalation policy"
  end

  def edit_escalation_policy(escalation_policy, fields)
    fields = parse_fields(fields)

    visit edit_escalation_policy_path(escalation_policy)

    if fields
      fill_in "Name", :with => fields["name"]
    else
      fill_in "Name", :with => "Test Policy"
    end
    click_on "Update Escalation policy"
  end

  def delete_escalation_policy(escalation_policy)
    visit escalation_policies_path

    within(:xpath, "//tr[contains(descendant::text(),'#{escalation_policy.name}')]") do
      click_on "Destroy"
    end
  end
end

World(EscalationPolicySteps)

Then /^#{capture_model} should be on the list of escalation policies$/ do |model|
  escalation_policy = model!(model)

  visit escalation_policies_path

  find("table").should have_content(escalation_policy.name)
end

Then /^"([^"]+)" should not be on the list of escalation policies$/ do |content|
  visit escalation_policies_path

  find("table").should_not have_content(content)
end
