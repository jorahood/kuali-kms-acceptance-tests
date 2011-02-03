Given /^document "([^\"]*)" does not exist$/ do |docid|
  steps %Q{
  * I go to delete a document
  * I fill in "Enter a docid" with "#{docid}"
  * I press "Delete document"
  }
end

Given /^document "([^\"]*)" exists with content$/ do |docid, pystring|
  Given "I go to add a document"
  And 'I fill in "ditacontent" with', pystring
  And "I fill in \"DocId\" with \"#{docid}\""
  And  'I press "Add to repository"'
end

#with single quotes since we may need double quotes in the string
Given /^I fill in "([^\"]*)" with '([^\']*)'$/ do |field, string|
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

Given /^I am using "([^"]*)"$/ do |host|
  Capybara.app_host = host
end

When /^I search for "([^"]*)" with audience="([^"]*)" and domain="([^"]*)"$/ do |query, audience, domain|
  # driver.browser.credentials works only with celerity
  # see http://celerity.rubyforge.org/yard/Celerity/Browser.html#credentials%3D-instance_method
  page.driver.browser.credentials = 'kbdevtest:EKQ6JNSC5A'
  visit "http://remote.kb.iu.edu/REST/v0.2//search/#{audience}?query=#{query}&domain=#{domain}"
end

When /^I do a quoted search for "([^"]*)" with audience="([^"]*)" and domain="([^"]*)"$/ do |query, audience, domain|
  steps %Q{ * I search for "%22#{query}%22" with audience="#{audience}" and domain="#{domain}" }
end
When /^I get the xml for doc "([a-z]{4})" with audience="([^"]*)" and domain="([^"]*)"$/ do |docid, audience, domain|
  # driver.browser.credentials works only with celerity
  page.driver.browser.credentials = 'kbdevtest:EKQ6JNSC5A'
  visit "http://remote.kb.iu.edu/REST/v0.2//document/#{audience}/#{docid}.xml?domain=#{domain}"
end
