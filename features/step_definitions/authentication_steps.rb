module AuthenticationSteps
  def login(email, password)
    visit new_user_session_path
    fill_in "Email", :with => email
    fill_in "Password", :with => password
    click_on "Sign in"
  end
end

World(AuthenticationSteps)

Given /^I am logged in as (?:an+ (user|admin))$/ do |role|
  email = "admin@example.com"
  password = "password"
  admin = FactoryGirl.create(role, :email => email, :password => password)
  login(email, password)
end
