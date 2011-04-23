When /^I create a test templist$/ do
  visit "https://kbhandbook.indiana.edu/test-kbss"
  steps %Q{
  * fill in "username" with "andytest"
  * fill in "password" with "abcd1234"
  * press "Log in"
  * fill in "id" with "ddud"
  * press "Search"
  }
end

When /^I create a test list$/ do
  steps %Q{
  * I create a test templist
  * fill in "newname" with "test cucumber list, delete me"
  * press "Save options"}
end

After('@cleanuplist') do
  click_button('Delete list')
end