Given /^I go to Sage's homepage$/ do
  @browser.open('http://140.182.144.96:8080/sagejpaspring/Home.do')
end

Then /^I should see a web page$/ do
@browser.is_element_present("css=body")
end

Then /^I should see "([^\"]*)"$/ do |arg1|
  @browser.is_text_present("Hello").should be_true
end

