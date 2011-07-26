# the iframe id that Kuali puts all portal content within
def frame_id
  'iframeportlet'
end

Given /^(?:|I )am logged in as "([^"]*)"$/ do |username|
  steps %Q{
  Given I go to the homepage
  * fill in "__login_user" with "#{username}"
  And press "Login"
  }
end

Given /^document "([^"]*)" does not exist$/ do |docid|
  steps %Q{
  Given I go to delete a document
  * fill in "Enter a docid" with "#{docid}"
  And press "Delete document"
  }
end

Given /^a document with id "([^"]*)" exists with content$/ do |docid, pystring|
  steps %Q{
  Given I follow "New content"
  * fill in "document.documentHeader.documentDescription" with "an automated test doc" in the frame
  * fill in "document.kmsDocument.fileName" with "xxxx" in the frame
  * fill in "document.kmsDocument.content" in the frame with
  """
  #{pystring}
  """
  And press "save" in the frame
  }
end

#with single quotes since we may need double quotes in the string
Given /^(?:|I )fill in "([^"]*)" with '([^']*)'$/ do |field, string|
  fill_in(field, :with => string)
end

Given /^(?:|I )fill in "([^"]*)" with$/ do |field, pystring|
  fill_in(field, :with => pystring)
end

Given /^(?:|I )fill in "([^"]*)" in the frame with$/ do |field, pystring|
  within_frame frame_id() do
    fill_in(field, :with => pystring)
  end
end

When /^I follow the first link in the table in the frame$/ do
  within_frame frame_id() do
    with_scope("table tr:first-child td:first-child") do
      click_link("") # the links all have blank title attributes
    end
  end
end

When /^(?:|I )press "([^"]*)"(?: within "([^"]*)")? in the frame$/ do |button, selector|
  within_frame frame_id() do
    with_scope(selector) do
      click_button(button)
    end
  end
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"(?: within "([^"]*)")? in the frame$/ do |field, value, selector|
  within_frame frame_id() do
    with_scope(selector) do
      fill_in(field, :with => value)
    end
  end
end

When /^(?:|I )follow "([^"]*)"(?: within "([^"]*)")? in the frame$/ do |link, selector|
  within_frame frame_id() do
    with_scope(selector) do
      click_link(link)
    end
  end
end

Then /^(?:|I )should see "([^"]*)" within "([^"]*)" once$/ do |regexp, selector|
  within(selector) do |content|
    regexp = Regexp.new(regexp)
    content.should contain_once(regexp)
  end
end

Then /^(?:|I )should see "([^"]*)"(?: within "([^"]*)")? in the frame$/ do |text, selector|
  within_frame frame_id() do
    with_scope(selector) do
      if page.respond_to? :should
        page.should have_content(text)
      else
        assert page.has_content?(text)
      end
    end
  end
end

When /^(?:|I )search for "([^"]*)"$/ do |terms|
  steps %Q{
  Given I go to search
  * fill in "query" with #{terms}
  And press "Search"
  }
end

#so I can use single quotes around double-quoted search strings:
When /^(?:|I )search for '([^']*)'$/ do |terms|
  steps %Q{
  Given I go to search
  * fill in "query" with #{terms}
  And press "Search"
  }
end

Then /^(?:|I )should see element (.*)$/ do |element|
  page.should have_xpath("//#{element}")
end
