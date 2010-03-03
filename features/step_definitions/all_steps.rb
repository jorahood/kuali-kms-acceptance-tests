Given /^document "([^\"]*)" does not exist$/ do |docid|
  steps %Q{
  * I go to delete a document
  * I fill in "Enter a docid" with "#{docid}"
  * I press "Delete document"
  }
end

Given /^document "([^\"]*)" exists with content$/ do |docid, pystring|
  steps %Q{
  * I go to add a document
  * I fill in "ditacontent" with
  """
  #{pystring}
  """
  * I fill in "DocId" with "#{docid}"
  * I press "Add to repository"
  }
end

#with single quotes since we may need double quotes in the string
Given /^I fill in "([^\"]*)" with '(.*)'$/ do |field, string|
  fill_in(field, :with => string)
end

Given /^I fill in "([^\"]*)" with$/ do |field, pystring|
  fill_in(field, :with => pystring)
end

Then /^I should see "([^\"]*)" within "([^\"]*)" once$/ do |regexp, selector|
  within(selector) do |content|
    regexp = Regexp.new(regexp)
    content.should contain_once(regexp)
  end
end

When /^I search for "([^\"]*)"$/ do |terms|
  steps %Q{
  * I go to search
  * I fill in "query" with #{terms}
  * I press "Search"
  }
end

#so I can use single quotes around double-quoted search strings:
When /^I search for '([^\']*)'$/ do |terms|
  steps %Q{
  * I go to search
  * I fill in "query" with #{terms}
  * I press "Search"
  }
end

Then /^I should see element (.*)$/ do |element|
  page.should have_xpath("//#{element}")
end
