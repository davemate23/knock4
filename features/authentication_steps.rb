Given /^a knocker visits the signin page$/ do
  visit signin_path
end

When /^they submit invalid signin information$/ do
  click_button "Sign in"
end

Then /^they should see an error message$/ do
  expect(page).to have_selector('div.alert.alert-error')
end

Given /^the knocker has an account$/ do
  @knocker = Knocker.create(name: "Example Knocker", email: "knocker@example.com",
                      password: "foobar", password_confirmation: "foobar")
end

When /^the knocker submits valid signin information$/ do
  fill_in "Email",    with: @knocker.email
  fill_in "Password", with: @knocker.password
  click_button "Sign in"
end

Then /^they should see their profile page$/ do
  expect(page).to have_title(@knocker.name)
end

Then /^they should see a signout link$/ do
  expect(page).to have_link('Sign out', href: signout_path)
end