When /^I open (.+)$/ do |web_site|
  @response = visit web_site # this works for mechanize but not Selenium
end

Then /^I should see "([^\"]*)" within "([^\"]*)" once$/ do |regexp, selector|
  within(selector) do |content|
    regexp = Regexp.new(regexp)
    content.should contain_once(regexp)
  end
end

