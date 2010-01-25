def kb5_url
  "http://cowhorn.uits.indiana.edu:8080/sage-stg/KBDocMan"
end

def search_params
  "?action=search&query="
end

Given /^document "([^\"]*)" exists with content$/ do |docid, string|
  steps %Q{
  When I follow "Add document"
  And I fill in "ditacontent" with
  """
  #{string}
  """
  And I check "isTransform"
  And I fill in "DocId" with "#{docid}"
  And I press "Add to repository"
  }
end

Given /^I fill in "([^\"]*)" with $/ do |field, string|
  fill_in(field, :with => string)
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

When /^I search for "([^\"]*)"$/ do |terms|
  params = search_params + terms
  @response = visit(kb5_url + params)
end

#so I can use single quotes around double-quoted search strings:
When /^I search for '([^\']*)'$/ do |terms|
  params = search_params + terms
  @response = visit(kb5_url + params)
end

When /^I request doc ([a-z]{4})$/ do |docid|
  params = "?action=getdoc&docid=" + docid
  @response = visit(kb5_url + params)
end

Then /^I should see element (.*)$/ do |element|
  @response.should match_selector(element)
end

Then /^I should not see element (.*)$/ do |element|
  @response.should_not match_selector(element)
end

When /^I fill in "([^\"]*)" with$/ do |field, string|
  fill_in(field, :with => string)
end
