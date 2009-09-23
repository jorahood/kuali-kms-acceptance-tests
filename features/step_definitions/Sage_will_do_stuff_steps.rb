Given /^I open (.+)$/ do |web_site|
  @response = visit web_site # this works for mechanize but not Selenium
end

Then /^I should say "([^\"]*)"$/ do |arg1|
  puts response.body
end

