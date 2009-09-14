When /^I visit Google$/ do
  @browser.open('http://www.google.com/')
end

Then /^I should see "([^\"]*)"$/ do |arg1|
@browser.is_text_present('Google').should be_true
end

