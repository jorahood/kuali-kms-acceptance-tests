Given /^I open (.+)$/ do |web_site|
  #  @browser.open(web_site) # Selenium
  @response = visit(web_site) # Mechanize
end

Then /^I should say "([^\"]*)"$/ do |arg1|
  puts response.body
end

