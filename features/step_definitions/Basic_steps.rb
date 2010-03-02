def search_path
  "/sage-stg/kms/form/search.cat"
end

def doc_xml_path
  "/sage-stg/kms/form/get/xml.cat"
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

#with single quotes since we may need double quotes in the string
Given /^I fill in "([^\"]*)" with '(.*)'$/ do |field, string|
  fill_in(field, :with => string)
end

And /^I fill in "([^\"]*)" with$/ do |field, pystring|
  fill_in(field, :with => pystring)
end

Then /^I should see "([^\"]*)" within "([^\"]*)" once$/ do |regexp, selector|
  within(selector) do |content|
    regexp = Regexp.new(regexp)
    content.should contain_once(regexp)
  end
end

When /^I search for "([^\"]*)"$/ do |terms|
  visit search_path
  fill_in("query", :with => terms)
  click_button("Search")
end

#so I can use single quotes around double-quoted search strings:
When /^I search for '([^\']*)'$/ do |terms|
  visit search_path
  fill_in("query", :with => terms)
  click_button("Search")
end

When /^I request xml for doc ([a-z]{4})$/ do |docid|
  visit doc_xml_path
  page.should have_css('body')
#  click_button("Retrieve document")
end

Then /^I should see element (.*)$/ do |element|
  page.should have_xpath("//#{element}")
end
