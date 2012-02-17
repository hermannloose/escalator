module RotationSteps
  def add_rotation(fields)
    fields = parse_fields(fields)

    visit new_rotation_path

    if fields
      fill_in "Name", :with => fields["name"]
    else
      fill_in "Name", :with => "Test Policy"
    end
    click_on "Create Rotation"
  end

  def edit_rotation(rotation, fields)
    fields = parse_fields(fields)

    visit edit_rotation_path(rotation)

    if fields
      fill_in "Name", :with => fields["name"]
    else
      fill_in "Name", :with => "Test Rotation"
    end
    click_on "Update Rotation"
  end

  def delete_rotation(rotation)
    visit rotations_path

    within(:xpath, "//tr[contains(descendant::text(),'#{rotation.name}')]") do
      click_on "Destroy"
    end
  end
end

World(RotationSteps)

Then /^#{capture_model} should be on the list of rotations/ do |model|
  rotation = model!(model)

  visit rotations_path

  find("table").should have_content(rotation.name)
end

Then /^"([^"]+)" should not be on the list of rotations/ do |content|
  visit rotations_path

  find("table").should_not have_content(content)
end
