def kb5_url
  "https://test.uisapp2.iu.edu/sage-stg/KBServlet"
end

When /^I open (.+)$/ do |web_site|
  @response = visit web_site # this works for mechanize but not Selenium
end

Then /^I should see "([^\"]*)" within "([^\"]*)" once$/ do |regexp, selector|
  within(selector) do |content|
    regexp = Regexp.new(regexp)
    content.should contain_once(regexp)
  end
end

When /^I request doc ([a-z]{4})$/ do |docid|
  params = "?action=getdoc&docid=" + docid
  @response = visit(kb5_url + params)
end

Then /^I should see element (.*)$/ do |element|
  @response.should match_selector(element)
end
