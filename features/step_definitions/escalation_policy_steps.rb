module EscalationPolicySteps
  def add(fields)
    fields = parse_fields(fields)

    visit new_escalation_policy_path

    if fields
      fill_in "Name", :with => fields["name"]
    else
      fill_in "Name", :with => "Test Policy"
    end
    click_on "Create Escalation policy"
  end

  def edit(escalation_policy, fields)
    fields = parse_fields(fields)

    visit edit_escalation_policy_path(escalation_policy)

    if fields
      fill_in "Name", :with => fields["name"]
    else
      fill_in "Name", :with => "Test Policy"
    end
    click_on "Update Escalation policy"
  end

  def delete(escalation_policy)
    visit escalation_policies_path

    within(:xpath, "//tr[contains(descendant::text(),'#{escalation_policy.name}')]") do
      click_on "Destroy"
    end
  end
end

World(EscalationPolicySteps)

When /^I add #{capture_model}(?: with #{capture_fields})?$/ do |model, fields|
  factory, index = parse_model(model)
  case factory.to_sym
  when :escalation_policy
    add(fields)
  else
    raise RuntimeError, "Can't handle #{factory}."
  end
end

When /^I edit #{capture_model}(?: using #{capture_fields})?$/ do |captured, fields|
  item = model!(captured)

  case item
  when EscalationPolicy
    edit(item, fields)
  else
    raise RuntimeError, "Can't handle #{item.inspect}."
  end
end

When /^I delete #{capture_model}$/ do |captured|
  item = model!(captured)

  case item
  when EscalationPolicy
    delete(item)
  else
    raise RuntimeError, "Can't handle #{item.inspect}."
  end
end

Then /^#{capture_model} should be on the list of escalation policies$/ do |model|
  escalation_policy = model!(model)

  visit escalation_policies_path

  find("table").should have_content(escalation_policy.name)
end

Then /^"([^"]+)" should not be on the list of escalation policies$/ do |content|
  visit escalation_policies_path

  find("table").should_not have_content(content)
end
