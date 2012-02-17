When /^I add #{capture_model}(?: with #{capture_fields})?$/ do |model, fields|
  factory, index = parse_model(model)
  case factory.to_sym
  when :escalation_policy
    add_escalation_policy(fields)
  when :rotation
    add_rotation(fields)
  else
    raise RuntimeError, "Can't handle #{factory}."
  end
end

When /^I edit #{capture_model}(?: using #{capture_fields})?$/ do |captured, fields|
  item = model!(captured)

  case item
  when EscalationPolicy
    edit_escalation_policy(item, fields)
  when Rotation
    edit_rotation(item, fields)
  else
    raise RuntimeError, "Can't handle #{item.inspect}."
  end
end

When /^I delete #{capture_model}$/ do |captured|
  item = model!(captured)

  case item
  when EscalationPolicy
    delete_escalation_policy(item)
  when Rotation
    delete_rotation(item)
  else
    raise RuntimeError, "Can't handle #{item.inspect}."
  end
end
