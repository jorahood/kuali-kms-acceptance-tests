require 'nokogiri'

def kb5_url
  "http://cowhorn.uits.indiana.edu:8080/sage-stg/KBDocMan"
end

def search_url
  "#{kb5_url}?action=startSearch"
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

#with single quotation marks since we may need double quotes in it
Given /^I fill in "([^\"]*)" with '(.*)'$/ do |field, string|
  find_by_label_or_id(:text_field, field).set(string)
end

When /^I open (.+)$/ do |web_site|
  $browser.goto web_site
end

Then /^I should see "([^\"]*)" within "([^\"]*)" once$/ do |regexp, selector|
  within(selector) do |content|
    regexp = Regexp.new(regexp)
    content.should contain_once(regexp)
  end
end

When /^I search for "([^\"]*)"$/ do |terms|
  $browser.goto(search_url)
  $browser.text_field("query").value = terms
  $browser.button("Search").click
end

#so I can use single quotes around double-quoted search strings:
When /^I search for '([^\']*)'$/ do |terms|
  $browser.goto(search_url)
  $browser.text_field("query").value = terms
  $browser.button("Search").click
end

When /^I request doc ([a-z]{4})$/ do |docid|
  params = "?action=getdoc&docid=" + docid
  $browser.goto(kb5_url + params)
end

Then /I should see "(.*)"/ do |text|
  # from http://github.com/alvinschur/celerity-examples/blob/master/features/step_definitions/first_steps.rb
  $browser.html.should  =~ /#{text}/m
end

Then /^I should see element (.*)$/ do |element|
  Nokogiri::XML($browser.page.as_xml).at_css(element).should_not be_nil
end

Then /^I should not see element (.*)$/ do |element|
  Nokogiri::XML($browser.page.as_xml).at_css(element).should be_nil
end
