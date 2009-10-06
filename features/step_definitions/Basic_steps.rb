When /^I open (.+)$/ do |web_site|
  @response = visit web_site # this works for mechanize but not Selenium
end

When /^I search for "([^\"]*)"$/ do |query|
  fill_in("terms", :with => query)
  click_button "Go"
end

